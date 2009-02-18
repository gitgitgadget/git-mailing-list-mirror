From: Brent Goodrick <bgoodr@gmail.com>
Subject: Re: Is there a way to exclude user-specified files or directories 
	from participating in merges?
Date: Tue, 17 Feb 2009 17:32:03 -0800
Message-ID: <e38bce640902171732j9b8801gca4223cdb96d2d34@mail.gmail.com>
References: <e38bce640902171649g765275a4n4e86d1d4f4aaf394@mail.gmail.com>
	 <7v1vtw367w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 02:34:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZbKW-00026n-MZ
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 02:34:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755836AbZBRBcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 20:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756688AbZBRBcH
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 20:32:07 -0500
Received: from rv-out-0506.google.com ([209.85.198.233]:64102 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757267AbZBRBcE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 20:32:04 -0500
Received: by rv-out-0506.google.com with SMTP id g37so2283019rvb.1
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 17:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jQ0pIzqICwRA9PRLL+0otFAWK+PLH9rVtpennlxPxIc=;
        b=C4guUjp++VW8xh6e4SanZu/3XYnwzgqBtoFu04uJydVjw7HnkmHTtZ1HBmah/U53Ko
         qU+dTyPQ623Ury1U/3D46VYuxpY/eq0cm8L36lwX0fQuurMxTiG99oz5BogR2YEvd2Qj
         mg5pBkv33l4tLv8UtYF4VzuM81PXamWSCet4c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Sxrubr8wPDWn3Ul9XdrXrhlxY80sujBGJUNR5MDyGQ7y8N4x+B1VVjfrs9hL2tbosf
         U+fMS2d4J/kHg5LZkUZDIKQK1VAx2SBD2kHPnU4em3ovFf9cpnUjfDt3RbCnfCHv5nAl
         REnSUaHuN4ELY/lhqQDooQgQ6pF/XVsjEfS3E=
Received: by 10.140.193.16 with SMTP id q16mr690729rvf.38.1234920724012; Tue, 
	17 Feb 2009 17:32:04 -0800 (PST)
In-Reply-To: <7v1vtw367w.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110490>

On Tue, Feb 17, 2009 at 5:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
> So at work, you would have a checkout of your work "deployment branch",
> and find needs to change things.  It is Ok to edit both work.sh and
> generic.sh (without being able to edit both, it would be hard to verify if
> the changes would work together) at this time, but don't commit the result
> in the work branch.
>
> Save the changes to work.sh away (e.g. "git diff work.sh >P.diff" and then
> "git checkout HEAD work.sh"), switch to the common branch, and commit the
> changes to the generic file.  Switch back to the deployment branch, merge
> the common branch (to pick up the changes to home.sh), reapply the changes
> specific to the deployment you saved earlier (e.g. "git apply P.diff"),
> tne commit the result.
>

Thanks. Well, I should have said in my initial request: "Without
manually forwarding changes from branch to branch and without having
to remember special rules about what I can and cannot merge into which
branch", since that is likely to get forgotten. :)

The answer I am hearing you say is that git doesn't have a way to
automatically exclude files akin to how rsync handles include/exclude.
 Is that what you are saying? Or, could the hook mechanism be
exploited to get this behavior?

bg
