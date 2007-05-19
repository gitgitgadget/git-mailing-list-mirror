From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH 2/2] Teach "delta" attribute to pack-objects.
Date: Sat, 19 May 2007 16:56:23 -0700
Message-ID: <56b7f5510705191656y1a5cdb1cn1b8b1082519f4bc3@mail.gmail.com>
References: <11795608912129-git-send-email-junkio@cox.net>
	 <11795608922961-git-send-email-junkio@cox.net>
	 <56b7f5510705190910h7e5ed03bnbc5a1b9a1369fc9f@mail.gmail.com>
	 <7v4pm8wpgc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, danahow@gmail.com
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 01:56:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpYmq-00023f-Ae
	for gcvg-git@gmane.org; Sun, 20 May 2007 01:56:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752346AbXESX42 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 19:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756410AbXESX42
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 19:56:28 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:40345 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752346AbXESX41 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 19:56:27 -0400
Received: by ug-out-1314.google.com with SMTP id 44so816303uga
        for <git@vger.kernel.org>; Sat, 19 May 2007 16:56:24 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VVvYvdXOEbduVdJ57ZHyizXZNMrdukpVWkwPTv8AIKAuB7iRceWqmvT5klf8zatXaaSKf8VLsYiSQYTrAbUTDPBR/Fr8tziPrOkYzsH+q+9w++On5MGvMZaUs/T3pmXpejS0QaxoNJeNmCmdpFLgl1Y4/lzvDw3jBmnCBi6PRc4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fdCUBj6f/lWM+62gOZwSiZFI9/XMWjCzLrIefQk6QKWAGQNct2Bdng8RiveWpR4s2wJCR1gsJcA242zqXJzCQkU1KtEVElL8zl71Q5VXsevJVbBvwGIqWOs6bj31HWiWeCw3kmlJdNQahvtR5l48iPk7myH6soWHzmZEd6+F7Go=
Received: by 10.78.165.16 with SMTP id n16mr826067hue.1179618984101;
        Sat, 19 May 2007 16:56:24 -0700 (PDT)
Received: by 10.78.129.3 with HTTP; Sat, 19 May 2007 16:56:23 -0700 (PDT)
In-Reply-To: <7v4pm8wpgc.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47784>

On 5/19/07, Junio C Hamano <junkio@cox.net> wrote:
> "Dana How" <danahow@gmail.com> writes:
> > ...  But such an attribute should be
> > ignored when --stdout is in effect -- it only affects on-disk
> > repacking, not packing for transfers, which is why it's named "repack".
>
> Yes -- if we want to have an option to keep objects selectively
> left out of packs in loose format, you would need 'repack' which
> acts differently between the server-feeding-client case vs
> packing-repository case.
>
> Which is a bigger change that I did not want to show in the
> quick-and-clean patch, but I would agree we would want both.

OK -- I'll put this on the back-burner with the so-called
"ent:relative" patch and I'll revisit this once your "delta"
attribute shows up in next or master.

At the moment I'm experimenting on a git repository with
a 4.5GB checkout,  and 18 months of history in 4K commits
comprising 100GB (uncompressed) of blobs stored in
7 packfiles of 2GB or less.  Hopefully I'll be able to say
more about tweaking packing shortly.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
