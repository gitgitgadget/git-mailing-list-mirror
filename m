From: Benjamin Meyer <ben@meyerhome.net>
Subject: Re: [PATCH] Speed up commands that use rev-list when max-count is  specified.
Date: Sun, 21 Mar 2010 12:57:30 -0400
Message-ID: <10BD5DAD-16FB-40FB-A77B-955EA0ECD4CB@meyerhome.net>
References: <1269142267-17127-1-git-send-email-bmeyer@rim.com> <fabb9a1e1003210412n58a3b951x1de4543f11b888c4@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Benjamin C Meyer <bmeyer@rim.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 21 17:57:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtOT4-0002YP-GZ
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 17:57:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752730Ab0CUQ5d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 12:57:33 -0400
Received: from qmta13.westchester.pa.mail.comcast.net ([76.96.59.243]:57402
	"EHLO qmta13.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752661Ab0CUQ5c convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 12:57:32 -0400
Received: from omta15.westchester.pa.mail.comcast.net ([76.96.62.87])
	by qmta13.westchester.pa.mail.comcast.net with comcast
	id vqbv1d0051swQuc5DsxYHt; Sun, 21 Mar 2010 16:57:32 +0000
Received: from [192.168.3.101] ([71.192.50.29])
	by omta15.westchester.pa.mail.comcast.net with comcast
	id vt1F1d00H0dnthT3bt1GCp; Sun, 21 Mar 2010 17:01:17 +0000
In-Reply-To: <fabb9a1e1003210412n58a3b951x1de4543f11b888c4@mail.gmail.com>
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142834>

In the git repo a more extreme case doing something like git log -1 copy.c the patch will reduce the runtime by 70%.  Running it on every top level file in git ('for f in *; log -1 $f; done') goes from 9 minutes to 8:30.

-Benjamin Meyer

On Mar 21, 2010, at 7:12 AM, Sverre Rabbelier wrote:

> Heya,
> 
> On Sun, Mar 21, 2010 at 04:31, Benjamin C Meyer <bmeyer@rim.com> wrote:
>> Depending on the use case this can have a big impact on the running time.
> 
> Sounds promising, do you have any numbers?
> 
> -- 
> Cheers,
> 
> Sverre Rabbelier
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
