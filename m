From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v8 0/7] git-p4: add support for large file systems
Date: Sun, 4 Oct 2015 11:15:31 -0700
Message-ID: <DD450E04-582C-498A-92D8-D6A78ECB30F1@gmail.com>
References: <1443254104-14966-1-git-send-email-larsxschneider@gmail.com> <CAE5ih78tsDe-RAUOEjrGMBJU0sage37V1sL9QLPZhRQhb5GUCA@mail.gmail.com> <xmqqh9m73m7z.fsf@gitster.mtv.corp.google.com> <xmqqd1wv3lyc.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Luke Diamand <luke@diamand.org>, Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 04 20:15:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zinow-0002Cr-77
	for gcvg-git-2@plane.gmane.org; Sun, 04 Oct 2015 20:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649AbbJDSPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Oct 2015 14:15:34 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33864 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610AbbJDSPd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Oct 2015 14:15:33 -0400
Received: by padhy16 with SMTP id hy16so13229502pad.1
        for <git@vger.kernel.org>; Sun, 04 Oct 2015 11:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Em6z6TjYGEUuKEINAP5ljzi/uXUgnzVh1m58oYW/1bs=;
        b=IAi4kipP1Ow/rZHeI7+RTcWy1992TL/dgZUFavUZucnKQ/l/uUVDCyvAA15kkhyBDT
         ciCnKrSqzkA6reaNTLsL/whUYR6Sv6/Dfh1cTKV61XeKXCVKw55ZpLodEj9kU0HK3XUk
         6chdSGnXseIjWymHSNkp3eQ8hGxXOivVhBOoudy6zviNimbWteeqFmcDyPLpBp+b7FwY
         v0f3f0eEWxcBCIxfBP143l+ASzODP0gIGYzuHydTCkbcCwpk5TqdYzssOmOBBWBgR7Rq
         S2PVOaIx4LoVNotnDLddrEmF1LqgN7wjkccad8YKfoRc41VgLMcdOXNAgYsfvHvG8F3y
         wpKg==
X-Received: by 10.68.94.3 with SMTP id cy3mr33688325pbb.113.1443982532951;
        Sun, 04 Oct 2015 11:15:32 -0700 (PDT)
Received: from remdbq1n32.ads.autodesk.com (adsk-nat-ip3.autodesk.com. [132.188.71.3])
        by smtp.gmail.com with ESMTPSA id ya10sm23090776pbc.69.2015.10.04.11.15.32
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 04 Oct 2015 11:15:32 -0700 (PDT)
In-Reply-To: <xmqqd1wv3lyc.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279015>


On 03 Oct 2015, at 10:23, Junio C Hamano <gitster@pobox.com> wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Luke Diamand <luke@diamand.org> writes:
>> 
>>> All looks good to me, Ack.
>>> 
>>> One tiny thing perhaps Junio could comment on: the git commit message
>>> for 75abe9fa5b39980de27dfc33dd5b4f4b5926f34c, "git-p4: add optional
>>> type specifier to gitConfig reader" uses what looks like UTF-8 encoded
>>> left and right quotes, rather than regular ASCII quotes ("). I don't
>>> know if that matters.
>> 
>> Yeah, I noticed them, too.  In general, I'd prefer to avoid these
>> pretty-quotes myself, as they typically do not add much information
>> (unless nesting matters, which is usually not the case in the log
>> message, or something) and the primary effect of them is to force us
>> to step outside ASCII, which causes editors and pagers to misalign
>> for some people.
>> 
>> But it is not too huge an issue that it is worth to go back and fix
>> them, either.
> 
> Well, I looked at it again and it also replaced double-dash before
> option names like --bool and --int with something funny (are these
> em-dashes?), which is a more serious bogosity than pretty quotes, so
> I ended up amending the message for that commit after all.
> 
Oh. This was not intentional. I wonder how that happened. I will watch out for it in the future.

Thanks for fixing,
Lars
