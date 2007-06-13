From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] gitview: run blame with -M and -C
Date: Tue, 12 Jun 2007 21:59:18 -0700
Message-ID: <7vir9sh2l5.fsf@assigned-by-dhcp.pobox.com>
References: <11816697213806-git-send-email-aneesh.kumar@gmail.com>
	<1181669728642-git-send-email-aneesh.kumar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 06:59:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyKwz-0003X8-GY
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 06:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbXFME7U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 00:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbXFME7U
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 00:59:20 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:59363 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278AbXFME7T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 00:59:19 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070613045919.LKAW17635.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Wed, 13 Jun 2007 00:59:19 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id AszJ1X0041kojtg0000000; Wed, 13 Jun 2007 00:59:18 -0400
In-Reply-To: <1181669728642-git-send-email-aneesh.kumar@gmail.com> (Aneesh
	Kumar K. V.'s message of "Tue, 12 Jun 2007 23:05:21 +0530")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50014>

"Aneesh Kumar K.V" <aneesh.kumar@gmail.com> writes:

> From: Aneesh Kumar K.V <aneesh.kumar@gmail.com>
>
> pass -M  and -C option to git-blame so that blame browsing
> works when the data is copied over from other files.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>
> ---
>  contrib/gitview/gitview |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/contrib/gitview/gitview b/contrib/gitview/gitview
> index 286e974..01128f4 100755
> --- a/contrib/gitview/gitview
> +++ b/contrib/gitview/gitview
> @@ -530,7 +530,7 @@ class AnnotateWindow(object):
>  
>  		self.add_file_data(filename, commit_sha1, line_num)
>  
> -		fp = os.popen("git blame --incremental -- " + filename + " " + commit_sha1)
> +		fp = os.popen("git blame --incremental -M -C -C -- " + filename + " " + commit_sha1)

You do not have to say "-M -C -C"; "-C" would imply "-M"
anyway.
