From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [RFCv2 1/2] gitweb: add patch view
Date: Wed, 3 Dec 2008 12:33:52 +0100
Message-ID: <cb7bb73a0812030333n2cfdc745m3a910d2e8677e7fe@mail.gmail.com>
References: <1228298862-28191-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1228298862-28191-2-git-send-email-giuseppe.bilotta@gmail.com>
	 <7vbpvtecb6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Jakub Narebski" <jnareb@gmail.com>,
	"Petr Baudis" <pasky@suse.cz>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 12:35:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7q0d-0004wU-9m
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 12:35:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576AbYLCLdz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 06:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751537AbYLCLdz
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 06:33:55 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:39477 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351AbYLCLdy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 06:33:54 -0500
Received: by nf-out-0910.google.com with SMTP id d3so1817904nfc.21
        for <git@vger.kernel.org>; Wed, 03 Dec 2008 03:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ArW+wU4x7JSzrw6V3FiDennbfbETJpIzanAQP3q87Q4=;
        b=iMjA2bTha6afAoRyySur3e5eLTnmC5f0qeEFYlZ6y0eBlIBO8GC/qzOg/7FXAdG6eY
         hQUdgVIxSkVK6EEZtfby8AhVPqV48ni4ulRWznVYzu61WDgD80ms9wUlf/T5jq1UnGGV
         BLyzoj+9eXo0sFO3JW0jcmThpvJFzv2eNNp8k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=eWdNjoIPSxc4CpoTdGIz4rCbNmLnNPZB18PTPZoU+VPgft7+S5fjE8VmdnamNlXXM2
         oKJ1F10JZGwtjKPZFungp+4m+Eoc5QBlygBdgV40/9vHGQXctO1C/GY/8XTpa0tAqAll
         UpIpMnOyz0jNAwSnoqnmgXFJXLkJzQHolJFlQ=
Received: by 10.210.142.10 with SMTP id p10mr9982642ebd.95.1228304032641;
        Wed, 03 Dec 2008 03:33:52 -0800 (PST)
Received: by 10.210.79.12 with HTTP; Wed, 3 Dec 2008 03:33:52 -0800 (PST)
In-Reply-To: <7vbpvtecb6.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102245>

On Wed, Dec 3, 2008 at 12:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>> We thus create a new view that can be fed to git-am directly by exposing
>> the output of git format-patch directly. This allows patch exchange and
>> submission via gitweb. A hard limit (configurable, defaults to 100) is
>> imposed on the number of commits which will be included in a patchset,
>> to prevent DoS attacks on the server.
>
> Hmm, I would imagine that "snapshot" would be a much more effective way to
> do such an attack, and notice the way we prevent it is to selectively
> enable the feature per repository.
>
> Perhaps this configuration should also be a feature defined in %feature,
> overridable by each repository?  If you default it to "disabled" (as any
> new feature typically does), you do not have to yank a random number such
> as 100 out of thin air.

I thought about it, but then I thought it was way too useful for
single patches to disable the feature a priori. I'd rather make the
default limit much smaller (like the original 16 commits I had in
mind, or even less).



-- 
Giuseppe "Oblomov" Bilotta
