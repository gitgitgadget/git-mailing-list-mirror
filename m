From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Tue, 22 Jan 2008 10:06:05 +1300
Message-ID: <46a038f90801211306g3dd9a167wb74d06e444b18b93@mail.gmail.com>
References: <478E1FED.5010801@web.de>
	 <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org>
	 <478F99E7.1050503@web.de>
	 <alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org>
	 <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org>
	 <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se>
	 <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org>
	 <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org>
	 <alpine.LFD.1.00.0801210934400.2957@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Kevin Ballard" <kevin@sb.org>,
	"Peter Karlsson" <peter@softwolves.pp.se>,
	"Mark Junker" <mjscod@web.de>,
	"Pedro Melo" <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 22:06:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH3qo-0002vH-Az
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 22:06:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753933AbYAUVGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 16:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753227AbYAUVGJ
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 16:06:09 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:32090 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752806AbYAUVGH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 16:06:07 -0500
Received: by ug-out-1314.google.com with SMTP id z38so953672ugc.16
        for <git@vger.kernel.org>; Mon, 21 Jan 2008 13:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=3sDX0MpfVbj0oow/yBySS1EIwh7k3xnYvCcXHy+jTTI=;
        b=S9KD3JfvKXj5SKzEJqsYujXh5f9Sz/1X0BBq0hjYGEL8ni6mgmFfzj5B7vt9fchOXkVoEa0aIL41pLFoyvXKNBC8iF8FtaaTGF7ZSC/xAq1Mqmbc3bxObBVyxGoyIWd7272WSahl/62gjKeDP+TI2tZXvMIrVzZF++z1guMx7aI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T5FcoExixj15IuWwixoMQkxkacpeZqndRgcj6eydiqTqfVjrkTFIeFFPIQw0jezv8UBf0O3xMSpr57lXPy0TG9DsYAsYRlonyr6T6NSPIG0+T1OnHNiOH3dw2G871iNdNOBddvZtw+iMf9bV4BNEEZB66H4idB/FJYgpbrA/J7U=
Received: by 10.66.240.12 with SMTP id n12mr5192800ugh.9.1200949565771;
        Mon, 21 Jan 2008 13:06:05 -0800 (PST)
Received: by 10.66.252.2 with HTTP; Mon, 21 Jan 2008 13:06:05 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0801210934400.2957@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71339>

On Jan 22, 2008 7:12 AM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> Now, git _also_ heavily depends on the actual encoding of those
> codepoints, since we create hashes etc, so in fact, as far ass git is
> concerned, names have to be in some particular encoding to be hashed, and
> UTF-8 is the only sane encoding for Unicode. People can blather about
> UCS-2 and UTF-16 and UTF-32 all they want, but the fact is, UTF-8 is
> simply technically superior in so many ways that I don't even understand
> why anybody ever uses anything else.
>
> So I would not disagree with using UTF-8 at all.

Linus,

(slightly offtopic) are you praising UTF-8 as storage format (for disk
and network) or in general? UTF-8-aware string ops like counting
characters seem to me a horrendous thing at the ASM level.

More on topic, I suspect Kevin's experience is more on end-user apps,
where input sanitization and even canonicalisation are common
practice. From a kernel and filesystems POV, a filename is data as
sacred as file data. On the webapp world, we "corrupt" user input
liberally to avoid XSS attacks and the like. In some cases, these
practices are stupid and can be replaced with escaping data properly,
but in other cases, the web platform is so broken that there's no
option.

At least in Moodle we store *exactly*  what the user POSTed and
cleanup^Wcorrupt it when displaying it, so that if it does happen that
the cleanup was buggy, we never corrupted the data.

So no point in calling eachother stupid this much. Once is enough ;-)
And no point in arguing that something that is ok for an end-user app
is a good design decision for an OS.


martin
