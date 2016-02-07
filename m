From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v1] config: add '--sources' option to print the source of a config value
Date: Sun, 7 Feb 2016 20:44:50 +0100
Message-ID: <278405D6-873C-4E73-965B-543D66A893D7@gmail.com>
References: <1454661750-85703-1-git-send-email-larsxschneider@gmail.com> <20160205112001.GA13397@sigill.intra.peff.net> <56B48803.9080909@gmail.com> <20160205135855.GA19154@sigill.intra.peff.net>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 07 20:44:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSVGU-0002At-9i
	for gcvg-git-2@plane.gmane.org; Sun, 07 Feb 2016 20:44:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754457AbcBGToy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2016 14:44:54 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36896 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbcBGTox convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Feb 2016 14:44:53 -0500
Received: by mail-wm0-f50.google.com with SMTP id g62so91226431wme.0
        for <git@vger.kernel.org>; Sun, 07 Feb 2016 11:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kzb1AHLsXRXRy0VKd4VCw/WH0/koGP3l3p0xuRIJ2t8=;
        b=z7+aDqAzAxNbWZ4IekA/S8Qp2a08qCmOAwJW3K+bxu2lohkMWrdx2Ef83exLSZH+oP
         D6PnN7gt6PNwfsBMikamQ/Da6VSUp3SFjQcj+gdI4UzcqHNOgsRXXypTWn/vKEdwwIfP
         i31lZAxXDm3mBznG/HctJDS6udDk2cr0BLP2ycQS5Ut3zaFmDnm94Ns4ixsjl8yARB5G
         MfLIa9dEdx7iSgvxrWtmp8mo3kwjGg+YJaw2SIUJOENmjBTX/L+XVoI8V4nAQwElWJRR
         h5dn23shEx/H6wQGTiCySuFy0YSflW2daXTmXj276ZH0m4j29K/pm1kf0fZqK8rCLAxy
         1YtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=kzb1AHLsXRXRy0VKd4VCw/WH0/koGP3l3p0xuRIJ2t8=;
        b=HG03uBauP24hLUDzZDtty+Dcev5NKdkolr7A3LlrvurcBevs333yi82RSJ7wtaIykR
         YOXz8joWD/BpeKVcogGohxzDNg9kbq7T3XtvxwZtzyXyJrWgeIy7guNTCOdA7BY4owL0
         6qOr8Q+b4ZGcmC6SK3Q/iwlfN6Jxu4kSxC/i/67ZzX21TIZtq/xExOZT2H6zFOZq8xox
         0OlvqBTOt3mJeGAIdwBjwXE8q6apJL+j/e2ZkgLqKiNRBbkmCfNA/E5ROCLz0V6ekh4E
         7sdhq6NFzDKgb16m2/Pys9UUhdA/azMexWGTkZ5fTD1df7vM82f2E/ojbvGEpdRXDPjg
         mlGQ==
X-Gm-Message-State: AG10YOR/IUTmBGfTIE1LBA/UKs/yAjcDyzJb5VyK6EkoyU3RtYxNw5Rl3vAAp7K8oXVdtQ==
X-Received: by 10.28.188.195 with SMTP id m186mr16154629wmf.64.1454874292742;
        Sun, 07 Feb 2016 11:44:52 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB606F.dip0.t-ipconnect.de. [93.219.96.111])
        by smtp.gmail.com with ESMTPSA id lh1sm26121481wjb.20.2016.02.07.11.44.51
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Feb 2016 11:44:52 -0800 (PST)
In-Reply-To: <20160205135855.GA19154@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285738>


On 05 Feb 2016, at 14:58, Jeff King <peff@peff.net> wrote:

> On Fri, Feb 05, 2016 at 12:31:15PM +0100, Sebastian Schuberth wrote:
> 
>>> I'm not sure returning here is the best idea. We won't have a config
>>> filename if we are reading from "-c", but if we return early from this
>>> function, it parses differently than every other line. E.g., with your
>>> patch, if I do:
>>> 
>>>  git config -c foo.bar=true config --sources --list
>>> 
>>> I'll get:
>>> 
>>>  /home/peff/.gitconfig <tab> user.name=Jeff King
>>>  /home/peff/.gitconfig <tab> user.email=peff@peff.net
>>>  ...etc...
>>>  foo.bar=true
>>> 
>>> If somebody is parsing this as a tab-delimited list, then instead of the
>>> source field for that line being empty, it is missing (and it looks like
>>> "foo.bar=true" is the source file). I think it would be more friendly to
>>> consumers of the output to have a blank (i.e., set "fn" to the empty
>>> string and continue in the function).
>> 
>> Or to come up with a special string to denote config values specified on the
>> command line. Maybe somehting like
>> 
>>    <command line> <tab> foo.bar=true
>> 
>> I acknowledge that "<command line>" would be a valid filename on some
>> filesystems, but I think the risk is rather low that someone would actually
>> be using that name for a Git config file.
> 
> Yeah, I agree it's unlikely. And the output is already ambiguous, as the
> first field could be a blob (though I guess the caller knows if they
> passed "--blob" or not). If we really wanted an unambiguous output, we
> could have something like "file:...", "blob:...", etc. But that's a bit
> less readable for humans, and I don't think solves any real-world
> problems.
> 
> So I think it would be OK to use "<command line>" here, as long as the
> token is documented.
Sounds good to me. I'll add it!

> Are there any other reasons why current_config_filename() would return
> NULL, besides command-line config? I don't think so. It looks like we
> can read config from stdin, but we use the token "<stdin>" there for the
> name field (another ambiguity!).
During my testing I haven't found any other case either. To be honest
I didn't know the "stdin" way to set the config! I added a test case for 
that, too!

Thanks,
Lars