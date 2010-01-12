From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Interest in locking mechanism?
Date: Tue, 12 Jan 2010 14:01:42 -0500
Message-ID: <32541b131001121101i76ad8062p3a7f3571ad86b0ce@mail.gmail.com>
References: <1263319565-sup-1767@ezyang>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: "Edward Z. Yang" <ezyang@mit.edu>
X-From: git-owner@vger.kernel.org Tue Jan 12 20:02:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUm0W-0002hZ-15
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 20:02:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754695Ab0ALTCH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Jan 2010 14:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753879Ab0ALTCG
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 14:02:06 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:43338 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753952Ab0ALTCE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jan 2010 14:02:04 -0500
Received: by ywh6 with SMTP id 6so22740999ywh.4
        for <git@vger.kernel.org>; Tue, 12 Jan 2010 11:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=20yhSMptJM3/SibEbAOBs5zGQY+L2HzWrv8Tu/bQg2c=;
        b=cHzQZpcPrNh0DyNHShgAuTsUdc4tVdDkpl3IZ5KZHfW5FoWUntzqWywOx0LZWF0gEU
         nXLbZrKW3Piz39P/q+6urm63UeYY413TDbR704HNlt7cKKXQe67jBj/RB7kyNjC2S0UK
         9mbKc2M4t1GbOV2vgV90pZ8Tk6TkCgdHmC5j4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=bD+7cTZAHcr/tI2D1nDioxt3k/MzZEOT4qF6HpUuswG/EAcLxjq1tnJIYYFkz1sEmM
         ZVSGMiV7tEyp9ASTDxM9YN6yVUBW01BZV9lKqF+kaEyHL5EVp9penP9AOvjpF6SpqaOm
         LhNii8JM3OITfhxFAwazmD7HXfE8OBSaqrmWE=
Received: by 10.151.1.26 with SMTP id d26mr7247698ybi.241.1263322922209; Tue, 
	12 Jan 2010 11:02:02 -0800 (PST)
In-Reply-To: <1263319565-sup-1767@ezyang>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136750>

On Tue, Jan 12, 2010 at 1:10 PM, Edward Z. Yang <ezyang@mit.edu> wrote:
> I have a few friends that still use RCS for their version control
> needs. =A0We have argued over various points between RCS and Git, and
> as far as I can tell the one thing RCS has that Git does not is
> a locking mechanism. =A0That is to say, co -l checks out a file and
> also gives you a lock on it, preventing others from futzing with it,
> and ci -u checks in the file and releases your lock. =A0This is
> useful if you have a shared working copy on a multiuser system or
> on a network file system, and you don't want conflicts.

If what you want is just one shared working copy with locking, then
what you want is RCS.  Why change what's not broken?  You're not doing
anything distributed or even any branching, and you don't need to
atomically commit multiple files at once (which would be very
confusing if more than one person is changing stuff in the current
tree), so git doesn't seem buy you anything.

There are lots of arguments that the central-shared-copy-with-locking
is obsolete.  It's been obsolete since at least CVS (the "concurrent
versions system", named after the fact that you didn't have to have
one central working copy).  But if you don't agree that this model is
obsolete, you might as well use a tool that treats your use case as a
first class citizen.

Have fun,

Avery
