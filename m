From: Caleb Cushing <xenoterracide@gmail.com>
Subject: Re: how do I resolve this merge manually + mergetool bug
Date: Tue, 24 Feb 2009 03:32:50 -0500
Message-ID: <81bfc67a0902240032t783abcabgaf8fa13b2a43e48@mail.gmail.com>
References: <81bfc67a0902232204y7a1e9a91x6cbf751319664734@mail.gmail.com>
	 <20090224074727.GA23927@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Tue Feb 24 09:34:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbsk9-0002oi-7z
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 09:34:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752708AbZBXIcy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 03:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbZBXIcx
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 03:32:53 -0500
Received: from qw-out-2122.google.com ([74.125.92.26]:44347 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbZBXIcw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 03:32:52 -0500
Received: by qw-out-2122.google.com with SMTP id 5so1701247qwi.37
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 00:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=B2MCAcmwY+jIrCVpxMWYsGNcfTMArzHTjGtaVPR9VOM=;
        b=jbuVMGg6Cb+JpNiBPD7nz13albLYfj/EqmL7u2Ps+VUL1WuXgNH//wEJHQqPy3JOpZ
         a1xKIMNhW/k7EA+L+0ncOWJnXdFIkUY89hIe0Se3sLsnxmTr/zwbUXPAQrSCoXk541j4
         J57QuvroTk20W/ktutMYsYE1yFfPc2gQhA8E4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UIZ/MUcwTSVBO/XiL8Ve2KJtJ8yrHq45jndjpmBnctMSc1qbSwosel+SSm70BKV+Xe
         vIG6ThRIHCcJMASC1x/RzWeqZEqVXNg7Recy9eH72t29BE1xRNrm1QXrjc7LTF5hP5te
         SZfBTDeNjEO02MGknzX2AhMpVGfohu5aOUrfE=
Received: by 10.229.85.132 with SMTP id o4mr1804574qcl.0.1235464370410; Tue, 
	24 Feb 2009 00:32:50 -0800 (PST)
In-Reply-To: <20090224074727.GA23927@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111235>

On Tue, Feb 24, 2009 at 2:47 AM, Charles Bailey <charles@hashpling.org> wrote:
> I'll look at adding
> a test case to mergetool and see how easy it is to get it to handle
> this case better.

few weeks back I created a patch for mergetool, it was rejected
ultimately on the basis that it had to cleanup temporary files and in
reality this was a problem with a lot of mergetool, the suggestion was
made that mergetool needs refactoring. I believe this problem is a
similar symptom. basically mergetool should touch my files before I
tell it what to do. if it has to move and back up my files before
deciding then at the very least it should copy them back into place if
I delete the remote. preferably in this case though it would just
delete the remote or backup my local files and copy the remote in
after I told it what to do (or maybe even delete my local files).
-- 
Caleb Cushing

http://xenoterracide.blogspot.com
