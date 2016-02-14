From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v3 1/3] git-config.txt: describe '--includes' default behavior
Date: Sun, 14 Feb 2016 13:17:43 +0100
Message-ID: <0FE601E5-B926-4E23-9FA5-2F898C12BBB9@gmail.com>
References: <1455373456-64691-1-git-send-email-larsxschneider@gmail.com> <1455373456-64691-2-git-send-email-larsxschneider@gmail.com> <20160213171704.GF30144@sigill.intra.peff.net>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, sschuberth@gmail.com,
	ramsay@ramsayjones.plus.com, sunshine@sunshineco.com,
	hvoigt@hvoigt.net, sbeller@google.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 14 13:18:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUvdE-0007eY-V8
	for gcvg-git-2@plane.gmane.org; Sun, 14 Feb 2016 13:18:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbcBNMRr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2016 07:17:47 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33300 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269AbcBNMRq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2016 07:17:46 -0500
Received: by mail-wm0-f65.google.com with SMTP id c200so11121560wme.0
        for <git@vger.kernel.org>; Sun, 14 Feb 2016 04:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=XsLAfEHnt5Z6RcwfWa8eJMUmJDi0jXC99fpPxbkUshU=;
        b=ascv5vrzX7Fage7YGgGx1vCPmsUchDGp2tsh0akqWk5ug4mvlSIs5IyxirVVeBIz9P
         m+MDbxiFpOgUAMz7OQD2jmbDVJT7v00+hMF3POZGoN0/ZMgxlUBeZsL3U2vMxt9qHgVT
         eRnQ4jYHRgY/avK32xepM5avTpvErAsAlzXsPdRzMOlz9f1eKQlEeGY7at+C0OyNrKC1
         IVltjgpFbbFDaUIgGebBDrp2FJ4wOgVlV3oAvVDVmMdLvSMb4mtx8JYXqfT69TzqyDU4
         9g2kcu8VaGYRNMS79OWl7k9rHNKaBp8KNIzgpf6F9sABcZDuOv7sAysWf2UgbHHPDkKT
         bkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=XsLAfEHnt5Z6RcwfWa8eJMUmJDi0jXC99fpPxbkUshU=;
        b=YD9+bqmLNq2cek+X+q1ZfIuLPnCR/6zZwXZSLcawGMiRB/T7j8l9SKb8Isj/n/vZzV
         ThSufLpW1WTdkCwffh9zJWUC92VG+dFNWzyrOzwiLyxEKkSXLX0UzLFhsmRlKykmXdrb
         cvyF709eQBdpqx1xQ6+zAqXPoAJAjhZzzQjQTn5Y9oe9UeSgFwDPON0sX/QrnR0qkB0k
         Hp8GWoKEYfswhzJGJ4+Km1iXGYXTynKliR5M422GsTvj42sVoDaM8b2MIbYK2+ve+4+t
         iqkrqsBydFBESm3YcoSxLUCIbi5GgOITb5MlCEaT/bvyvE0lRrUXoc+dbWxFKi946KUs
         tNiw==
X-Gm-Message-State: AG10YOSQxiQG5NBOJx/OGfuUJ+ZtRHsHDzDws+RZetv4IgBz2jaMCPMJGPkJf7seBoteKQ==
X-Received: by 10.28.153.14 with SMTP id b14mr8020112wme.93.1455452265110;
        Sun, 14 Feb 2016 04:17:45 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB4789.dip0.t-ipconnect.de. [93.219.71.137])
        by smtp.gmail.com with ESMTPSA id c136sm10746582wmd.3.2016.02.14.04.17.43
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 Feb 2016 04:17:44 -0800 (PST)
In-Reply-To: <20160213171704.GF30144@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286149>


On 13 Feb 2016, at 18:17, Jeff King <peff@peff.net> wrote:

> On Sat, Feb 13, 2016 at 03:24:14PM +0100, larsxschneider@gmail.com wrote:
> 
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> Helped-by: Jeff King <peff@peff.net>
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>> Documentation/git-config.txt | 4 +++-
>> 1 file changed, 3 insertions(+), 1 deletion(-)
>> 
>> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
>> index 2608ca7..59b1c95 100644
>> --- a/Documentation/git-config.txt
>> +++ b/Documentation/git-config.txt
>> @@ -219,7 +219,9 @@ See also <<FILES>>.
>> 
>> --[no-]includes::
>> 	Respect `include.*` directives in config files when looking up
>> -	values. Defaults to on.
>> +	values. Defaults to off when reading a specific config file
>> +	(e.g. via `--file` or via `--local` etc.), and to on when
>> +	generically reading all config.
> 
> Hmph. I wondered why you were confused about this the other day, when I
> checked my Documentation/git-config.txt and found that yes, we do indeed
> document this behavior. I did not realize then that my patch from:
> 
>  http://article.gmane.org/gmane.comp.version-control.git/262641
> 
> was never picked up (but of course I've been carrying it in my tree for
> a year). I guess maybe you found it, given the similarity of the
> wording. I mildly prefer the wording and formatting of my original, but
> I am OK either way. :)

Oh. Believe it or not but the similarity is coincidental. I referenced you 
("Helped-by") because you explained the expected "includes" behavior to
me in your v2 review of my series. If I would have found your patch, I 
would have said so.

I am happy to use your wording. How should I proceed? Should I just drop 
my "git-config.txt" patch from my series or should I integrate your patch 
into my series? If the latter, then does the patch require a "Signed-off-by:"
by me?

Thanks,
Lars
