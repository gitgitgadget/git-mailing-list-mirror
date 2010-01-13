From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [RFC 0/2] Git-over-TLS (gits://) client side support
Date: Wed, 13 Jan 2010 15:57:53 +0200
Message-ID: <20100113135753.GA7095@Knoppix>
References: <1263388786-6880-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <fcaeb9bf1001130539p2971caavd101d46de9269769@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 14:58:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV3jZ-00064f-DK
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 14:58:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754928Ab0AMN57 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 08:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754537Ab0AMN57
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 08:57:59 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:51291 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754167Ab0AMN57 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 08:57:59 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id 6A29318D439;
	Wed, 13 Jan 2010 15:57:57 +0200 (EET)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A056B2675F5; Wed, 13 Jan 2010 15:57:57 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 568D6407C;
	Wed, 13 Jan 2010 15:57:54 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <fcaeb9bf1001130539p2971caavd101d46de9269769@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136821>

On Wed, Jan 13, 2010 at 08:39:12PM +0700, Nguyen Thai Ngoc Duy wrote:
>
> Can we rely on an external program, like stunnel, to do the job instead?

No. The way authentication is done is very unusual. I don't think stunnel (or
anything else) can deal with such modes. And the reason authentications are
done like they are done in order to minimize points of failure (getting
really annoyed at failure modes sshd introduced was one big reason for 
writing this).

I _definitely_ do not want to mess with X.509. And its not just about me
messing with it, it is also about pushing it to users.

And one would need custom daemon anyway even if one used stunnel. 
git-daemon just can't deal with authentication data.

-Ilari
