From: Jeremiah Foster <jeremiah.foster@pelagicore.com>
Subject: Re: http-smart-backend: can clone, cannot push
Date: Tue, 1 Jun 2010 17:53:59 +0200
Message-ID: <3A4DAEA3-C7F4-4163-9ABA-37443BB025AB@pelagicore.com>
References: <E66CC81A-CCED-4D8E-AE7C-C02FB0AF6F6C@pelagicore.com> <AANLkTimqncJ7aqi_0AvjNimyIPsbVN1zSkAQ1LrPhwne@mail.gmail.com> <B61D22CA-45BA-49DA-984B-A7F7090FAE55@pelagicore.com> <AANLkTin43VO3FA9dEjAx9w6FRwLK7FpqqO5rA6wKFZgn@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 01 17:54:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJTn9-0003tZ-Ng
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 17:54:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168Ab0FAPyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 11:54:06 -0400
Received: from av10-2-sn2.hy.skanova.net ([81.228.8.182]:36812 "EHLO
	av10-2-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932161Ab0FAPyE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Jun 2010 11:54:04 -0400
Received: by av10-2-sn2.hy.skanova.net (Postfix, from userid 502)
	id 3FE8837FCB; Tue,  1 Jun 2010 17:54:00 +0200 (CEST)
Received: from smtp4-2-sn2.hy.skanova.net (smtp4-2-sn2.hy.skanova.net [81.228.8.93])
	by av10-2-sn2.hy.skanova.net (Postfix) with ESMTP id 07EA037E78
	for <git@vger.kernel.org>; Tue,  1 Jun 2010 17:54:00 +0200 (CEST)
Received: from [10.8.36.139] (194-237-7-146.customer.telia.com [194.237.7.146])
	by smtp4-2-sn2.hy.skanova.net (Postfix) with ESMTP id ED62537E45
	for <git@vger.kernel.org>; Tue,  1 Jun 2010 17:53:59 +0200 (CEST)
In-Reply-To: <AANLkTin43VO3FA9dEjAx9w6FRwLK7FpqqO5rA6wKFZgn@mail.gmail.com>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148131>


On Jun 1, 2010, at 17:40, Tay Ray Chuan wrote:
> 
> On Tue, Jun 1, 2010 at 11:24 PM, Jeremiah Foster
> <jeremiah.foster@pelagicore.com> wrote:
>> 
>> * The requested URL returned error: 403
> 
> You're getting a 403 Forbidden here. What authentication method were
> you expecting?

I thought that by exporting "GIT_SSL_NO_VERIFY=true" that it would not matter.
> 
> FYI, after this, the requests show that git is falling back to the
> "dumb"/WebDAV protocol, which the server doesn't seem to support.

Yeah, I can see in the logs that it is calling PROPFIND, which is clearly a webDav command. The weird thing is that I know this repo is checked out of a smart http transport dir, at least when I clone it. I don't understand how I could have set it up correctly for cloning and then not be able to push properly back. 

Maybe I _have_ to be authenticated since the documentation states:  "If the client is authenticated, thereceive-pack service is enabled, which serves git send-pack clients, which is invoked from git push." 

Jeremiah
