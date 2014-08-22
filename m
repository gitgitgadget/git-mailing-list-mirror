From: Howard Chu <hyc@symas.com>
Subject: Re: Wishlist: git fetch --reference
Date: Thu, 21 Aug 2014 22:25:34 -0700
Message-ID: <53F6D44E.7040907@symas.com>
References: <53F6B1AB.3030706@symas.com> <20140822042057.GD27992@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 22 07:25:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKhM6-00008Y-92
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 07:25:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755857AbaHVFZi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 01:25:38 -0400
Received: from zill.ext.symas.net ([69.43.206.106]:59177 "EHLO
	zill.ext.symas.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998AbaHVFZh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 01:25:37 -0400
Received: from cust233-73.nwewn.com ([78.155.233.73] helo=[192.168.1.103])
	by zill.ext.symas.net with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <hyc@symas.com>)
	id 1XKhM0-0008Lf-Qm; Thu, 21 Aug 2014 22:25:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:30.0) Gecko/20100101 Firefox/30.0 SeaMonkey/2.27a1
In-Reply-To: <20140822042057.GD27992@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255662>

Jeff King wrote:
> On Thu, Aug 21, 2014 at 07:57:47PM -0700, Howard Chu wrote:
>
>> I maintain multiple copies of the same repo because I keep each one checked
>> out to different branch/rev levels. It would be nice if, similar to clone
>> --reference, we could also use git fetch --reference to reference a local
>> repo when doing a fetch to pull in updates.
>
> I think it is just spelled:
>
>    echo $reference_repo >>.git/objects/info/alternates
>    git fetch
>
> We need "--reference" with clone because that first line needs to happen
> after clone runs "git init" but before it runs "git fetch". And if you
> cloned with --reference, of course, the alternates file remains and
> further fetches will automatically use it.

Aha, thanks, hadn't realized that. Just checked and yes, the alternates file 
is already set in all of these different copies.

-- 
   -- Howard Chu
   CTO, Symas Corp.           http://www.symas.com
   Director, Highland Sun     http://highlandsun.com/hyc/
   Chief Architect, OpenLDAP  http://www.openldap.org/project/
