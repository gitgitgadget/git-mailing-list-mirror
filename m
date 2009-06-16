From: Thomas Koch <thomas@koch.ro>
Subject: Re: Using git for code deployment on webservers?
Date: Tue, 16 Jun 2009 10:01:33 +0200
Message-ID: <200906161001.33678.thomas@koch.ro>
References: <200906160111.47325.ioe-git@rameria.de>
Reply-To: thomas@koch.ro
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ingo Oeser <ioe-git@rameria.de>
X-From: git-owner@vger.kernel.org Tue Jun 16 10:01:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGTc7-000768-W2
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 10:01:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbZFPIBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 04:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbZFPIBk
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 04:01:40 -0400
Received: from koch.ro ([93.90.184.107]:43012 "EHLO
	ve825703057.providerbox.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750830AbZFPIBj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Jun 2009 04:01:39 -0400
Received: from 84-72-56-244.dclient.hispeed.ch ([84.72.56.244] helo=jona.localnet)
	by ve825703057.providerbox.net with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <thomas@koch.ro>)
	id 1MGTbr-0000k7-Vv; Tue, 16 Jun 2009 10:01:36 +0200
User-Agent: KMail/1.11.4 (Linux/2.6.29-1-amd64; KDE/4.2.4; x86_64; ; )
In-Reply-To: <200906160111.47325.ioe-git@rameria.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121664>

Would it help, to share a read only GIT object store among all webservers via 
NFS?

Best regards, Thomas Koch

> [please CC me, as I'm not subscribed]
>
> Hi there,
>
> I try to use git in a quite unusual way.
>
> I have a bunch of servers (hundreds), which get regular pulls of web
> developer code. The code consists of images, flash files, scripting
> language files, you name it. An exported repo (just the files, no SCM
> metadata) contains up to 4GB of files.
>
> No I want to distribute changes the developers made in a tree like
> structure:
>
> main server --> slave_1 --> webserver_0815
>
>             |-> slave_2 --> webserver_2342
>             |
>                         |-> webserver_4711
>
> But with the following contraints:
> - Store as little as possible on the webservers.
>   One selected revision/tag is enough.
> - Transfer as little as possible data.
>   Cancel out addition and deletion on the fly.
> - Nearly atomic update of file tree (easy to implement outside git)
>
> Nice to have:
> - Instead of copying the files to their proper names,
>   hardlink them to their git objects.
>
> At the moment I always get more data than I need and have to store
> the repository AND the checked out data.
>
> I couldn't find a way so far to get around this. Is this possible?
> Any ideas are welcome.
>
> Many Thanks in Advance!
>
> Best Regards
>
> Ingo Oeser
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
Thomas Koch, http://www.koch.ro
