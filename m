From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Teach "git add -i" to colorize whitespace errors
Date: Fri, 7 Dec 2007 14:00:36 +0100
Message-ID: <822D2B27-2280-4A53-A242-B69726CF129D@wincent.com>
References: <1197030910-29638-1-git-send-email-win@wincent.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 14:01:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0cpw-0001Wl-Aj
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 14:01:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943AbXLGNBF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Dec 2007 08:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751707AbXLGNBE
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 08:01:04 -0500
Received: from wincent.com ([72.3.236.74]:41861 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751399AbXLGNBD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Dec 2007 08:01:03 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lB7D0bx1013566;
	Fri, 7 Dec 2007 07:00:38 -0600
In-Reply-To: <1197030910-29638-1-git-send-email-win@wincent.com>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67423>

El 7/12/2007, a las 13:35, Wincent Colaiuta escribi=F3:

> @@ -662,8 +648,10 @@ sub split_hunk {
> 			    (($n_cnt !=3D 1) ? ",$n_cnt" : '') .
> 			    " @@\n");
> 		unshift @{$hunk->{TEXT}}, $head;
> +		unshift @{$hunk->{DISPLAY}},
> +		    $use_color ? (colored $fraginfo_color, $head) : $head;
> 	}
> -	return map { $_->{TEXT} } @split;
> +	return @split;
> }


Actually, $diff_use_color would probably be more appropriate than =20
$use_color above.

Wincent
