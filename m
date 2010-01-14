From: Adam Nielsen <adam.nielsen@uq.edu.au>
Subject: Re: Unable to get "pretty" URL aliases working
Date: Thu, 14 Jan 2010 10:45:59 +1000
Organization: The University of Queensland
Message-ID: <4B4E6947.2020009@uq.edu.au>
References: <4B4ABDB5.9000203@uq.edu.au> <7v7hrpvzqa.fsf@alter.siamese.dyndns.org> <4B4BB2DC.4090203@uq.edu.au> <7vockytrwy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 01:47:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVDrZ-0007Bk-2d
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 01:47:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482Ab0ANAq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 19:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319Ab0ANAq5
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 19:46:57 -0500
Received: from mailhub3.uq.edu.au ([130.102.148.131]:38944 "EHLO
	mailhub3.uq.edu.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286Ab0ANAq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 19:46:56 -0500
Received: from smtp3.uq.edu.au (smtp3.uq.edu.au [130.102.128.18])
	by mailhub3.uq.edu.au (8.13.8/8.13.8) with ESMTP id o0E0jx0K008600;
	Thu, 14 Jan 2010 10:46:00 +1000
Received: from [192.168.173.208] (rrtd-it1.research.uq.edu.au [192.168.173.208])
	by smtp3.uq.edu.au (8.13.8/8.13.8) with ESMTP id o0E0jxSt024454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 14 Jan 2010 10:45:59 +1000
User-Agent: Thunderbird 2.0.0.23 (X11/20091130)
In-Reply-To: <7vockytrwy.fsf@alter.siamese.dyndns.org>
X-UQ-FilterTime: 1263429960
X-Scanned-By: MIMEDefang 2.58 on UQ Mailhub on 130.102.148.131
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136907>

>> What actually happens when you use the ssh:// style connection?
> 
> Be it ssh://host/full/path or host:/full/path or host:path/in/home, you
> log in as whatver ssh identifies you as to the server, and start a
> server-side git process over there.

Ah ok, that makes more sense.  Strange then if it's a server-side git 
process that it ignores the server's /etc/gitconfig where aliases can be 
set up.

> With ssh://host/path notation, there is no way to specify any relative
> path (i.e. "/path" part begins at root) so it will mean the same thing for
> everybody (unless you are getting chrooted or something), while host:path
> notation allows relative path which will be taken relative as where you
> are, i.e. home directory of the user on the server.

In that case I symlinked my repository folder to /git so that SSH users 
can "cd /git/project.git" and this seems to work well.  I can now use 
git URLs like ssh://server/git/project.git even though the repos are 
buried much deeper down in the tree.

Thanks for the explanations!

Cheers,
Adam.
