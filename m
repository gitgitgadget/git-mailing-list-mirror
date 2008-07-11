From: "Denis Bueno" <dbueno@gmail.com>
Subject: Re: git cherry-pick before archive
Date: Fri, 11 Jul 2008 12:18:23 -0400
Message-ID: <6dbd4d000807110918s1187abeaye6f249ff60b650fb@mail.gmail.com>
References: <6dbd4d000807110846m2921ddb9r88eb3986762b8f81@mail.gmail.com>
	 <alpine.DEB.1.00.0807111649290.8950@racer>
	 <6dbd4d000807110909n1ced22eeraef45af441c20cca@mail.gmail.com>
	 <20080711161158.GD10347@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Miklos Vajna" <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Jul 11 18:19:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHLLA-0006Rd-5Y
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 18:19:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753905AbYGKQS0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 12:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753903AbYGKQS0
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 12:18:26 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:23703 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025AbYGKQSZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 12:18:25 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1562267fgg.17
        for <git@vger.kernel.org>; Fri, 11 Jul 2008 09:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=4b71vvYKo/1tMqC3m66gqJIhlMKht4wsoRF0ki1Xkw0=;
        b=CDmw3XHBqdkOS/+hAkgf7Yotn5J3GXFHpOVdn2DnH70o+klE52V/S3zPR5z/U1qRyw
         dNvBh2HoPBYTHKGJgXKNUvH8b4YT+2KZRclgdSPtd2AhORP8B7C0pOTf9/yP/q/PhXH4
         XlCVtRyPaTZ6GfAcao7jDw1BZIYxJpM2tRWsE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=qqvlLp+gIVT7LazEhzqHv61SPXabcQeRX+BAXG97P6vijMeuYBMPjnicwaJE1z9wI1
         sJ/34MAuIZ73QYsuaUVOuSKbXu3AEvh3MoscWp0Z93lAQZBKEeCmFdCnKm3+PBDZB6Ot
         F1eI8XjstXFL1zjXp3y2zsA+t8uyxcy6ua5Cc=
Received: by 10.86.63.19 with SMTP id l19mr10085846fga.60.1215793103899;
        Fri, 11 Jul 2008 09:18:23 -0700 (PDT)
Received: by 10.86.59.7 with HTTP; Fri, 11 Jul 2008 09:18:23 -0700 (PDT)
In-Reply-To: <20080711161158.GD10347@genesis.frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88139>

On Fri, Jul 11, 2008 at 12:11, Miklos Vajna <vmiklos@frugalware.org> wrote:
> On Fri, Jul 11, 2008 at 12:09:02PM -0400, Denis Bueno <dbueno@gmail.com> wrote:
>> On Fri, Jul 11, 2008 at 11:51, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>> > $ git cherry-pick -n <bla>
>> > $ git archive --format=tar --prefix=pfx/ $(git write-tree) | gzip > prj.tgz
>> > $ git reset
>
> I guess he wanted to write 'git reset --hard' here ;-)

But that will undo local modifications to any uncommitted files, not
just those affected by the cherry-pick.  I don't want to do that.

>> Thank you!  This is much better.  The only thing that could improve it
>> is by some way to "un-cherry-pick" the applied change (so that after
>> "git reset" there are no local modifications to the file(s) changed by
>> cherry-picking <bla>).
>>
>> Is there an easy way to invert a patch to undo the change the original
>> patch introduced?
>
> git show <commit> | git apply -R?

Brilliant!  Thanks.  I didn't know about apply (or show for that matter ....).

-- 
 Denis
