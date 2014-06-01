From: Atsushi Nakagawa <atnak@chejz.com>
Subject: Re: Reset by checkout?
Date: Sun, 01 Jun 2014 11:56:21 +0900
Message-ID: <20140601115619.8218.B013761@chejz.com>
References: <20140531144610.754B.B013761@chejz.com> <m261kmmnva.fsf@linux-m68k.org>
Reply-To: Atsushi Nakagawa <atnak@chejz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sun Jun 01 05:03:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wqw3H-0004fz-Ol
	for gcvg-git-2@plane.gmane.org; Sun, 01 Jun 2014 05:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbaFAC4Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2014 22:56:25 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:59105 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbaFAC4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2014 22:56:25 -0400
Received: by mail-pd0-f174.google.com with SMTP id r10so2251749pdi.5
        for <git@vger.kernel.org>; Sat, 31 May 2014 19:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chejz.com; s=google;
        h=date:from:to:subject:cc:reply-to:in-reply-to:references:message-id
         :mime-version:content-type:content-transfer-encoding;
        bh=lP1J1Mzqm5pif0KSHAcVe+K6YCa++SsjzhtrS7ExUfk=;
        b=h04kots1bRHc5aP6Um+p1cuuqv22xmxidvQR6dKtWn1uRbXXzp/J74aZhKXxCTwvDo
         zGIXFmk5aU02iB5xioFhSoSHboy8drbTSiiPwApqweUxeGADWzs359YepeEo5bn1jY3F
         UpGksBzBzxsNMVWeJUAtaI1vbUj7IEG+pk7TU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:cc:reply-to:in-reply-to
         :references:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=lP1J1Mzqm5pif0KSHAcVe+K6YCa++SsjzhtrS7ExUfk=;
        b=mI01sWVA1Nx90OPMlra5XPobYWdNUvGDQxjfBJpz32Q1N+urB/lmF1EB0HZhYg98vT
         12TWzO08i00Qwv3RpxgKV2+rrH8zzMSGdnzbNza+cmz9BkV7BEB9g5jbf8AXt2e2Hajg
         zTGgD1yhIGyERmEwsgxT8m8UHZp3wBDbFUvJStOt35XP+m9jKcOJqAxQs+uYzBVWj/uJ
         wVGB/sa83o4lliAUmtnR2iF6K2J6GGZnLnW4hJjadeStmUGPfuxfx9ccsfUOnguTB7jl
         3xsOh/6edKK4m+oU2H486LOTBfOmrbSdDyYKe2pnjeUknNwbaUKIsPbwRa8s3gLEH2Yn
         /CGQ==
X-Gm-Message-State: ALoCoQn2vtBHk9GBL2Rsa7wUuSDLpvvP/BVX0jviZvVfJUiA8kbfj+bXFYMgNJgTLQ7wpx71kprH
X-Received: by 10.68.226.105 with SMTP id rr9mr30101114pbc.161.1401591383545;
        Sat, 31 May 2014 19:56:23 -0700 (PDT)
Received: from [127.0.0.1] (KD106168138162.ppp-bb.dion.ne.jp. [106.168.138.162])
        by mx.google.com with ESMTPSA id gg3sm13495367pbc.34.2014.05.31.19.56.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 31 May 2014 19:56:22 -0700 (PDT)
In-Reply-To: <m261kmmnva.fsf@linux-m68k.org>
X-Mailer: Becky! ver. 2.65.07 [en]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250517>

Andreas Schwab <schwab@linux-m68k.org> wrote:
> Atsushi Nakagawa <atnak@chejz.com> writes:
> 
> > Ok, the typical use case is: I'm on 'master' and I make a few test
> > commits.  Afterwards, I want to discard the commits and move back to
> > 'origin/master'.  I could type 'reset --hard origin/master' and risk
> > blowing away dirty files if I'm not careful.  Or, I could use "reset by
> > checkout" and be carefree.
> 
> I think that is what 'reset --keep' is doing.

I must admit, I didn't know about 'reset --keep'.  As you've pointed out,
it does look like the command I was after all along!  And to think that
it's been around since 1.7.1.

Thanks!


-- 
Atsushi Nakagawa
<atnak@chejz.com>
Changes are made when there is inconvenience.
