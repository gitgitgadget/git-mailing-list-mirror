From: Andre Masella <andre@masella.no-ip.org>
Subject: Re: Repository Security
Date: Tue, 23 Jan 2007 08:23:19 -0500
Message-ID: <200701230823.20061.andre@masella.no-ip.org>
References: <200701221433.13257.andre@masella.no-ip.org> <ep4q5e$ioc$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 22:16:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9T05-0003bP-K7
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 22:16:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965224AbXAWVQO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 16:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965447AbXAWVQO
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 16:16:14 -0500
Received: from tomts5-srv.bellnexxia.net ([209.226.175.25]:61655 "EHLO
	tomts5-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965224AbXAWVQN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 16:16:13 -0500
Received: from masella.no-ip.org ([74.12.158.59])
          by tomts5-srv.bellnexxia.net
          (InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP
          id <20070123211611.LFYS5067.tomts5-srv.bellnexxia.net@masella.no-ip.org>;
          Tue, 23 Jan 2007 16:16:11 -0500
Received: by masella.no-ip.org (Postfix, from userid 1003)
	id 3C685508FC; Tue, 23 Jan 2007 08:23:21 -0500 (EST)
To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KMail/1.9.5
In-Reply-To: <ep4q5e$ioc$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37569>

> > As I understand it, none of the repository backends allow any per-user
> > per-branch access control. SSH and HTTP come the closest with the right
> > hooks, but since the repository is writeable by those users, there is
> > little to stop them from changing the repository directly.
> I wonder if it would be enought for SSH (and perhaps HTTP/WebDAV access)
> just to rely on filesystem write access to refs/heads files (different
> files having different access rights), and filesystem ACLs.

It could probably be done, but it would be very complicated. For instance, if 
a user is allowed to run prune, then they must have permissions to delete 
files which would include any of the objects.

For DAV, this breaks down completely because all access to the repository will 
happen as the Apache user.
-- 
--Andre Masella (andre at masella.no-ip.org)
