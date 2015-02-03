From: Lukas Fleischer <git@cryptocrack.de>
Subject: Re: use-after-free leads to git-blame writing garbage in error message
Date: Tue, 03 Feb 2015 10:32:45 +0100
Message-ID: <20150203093245.3733.71523@typhoon>
References: <20150203091715.GA25445@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: "Jeff King" <peff@peff.net>
To: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 03 10:33:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIZr1-0008KB-EP
	for gcvg-git-2@plane.gmane.org; Tue, 03 Feb 2015 10:33:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754295AbbBCJcx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2015 04:32:53 -0500
Received: from elnino.cryptocrack.de ([46.165.227.75]:2340 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752293AbbBCJcu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Feb 2015 04:32:50 -0500
Received: by elnino.cryptocrack.de (OpenSMTPD) with ESMTPSA id 0bd43c8c;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	Tue, 3 Feb 2015 10:32:46 +0100 (CET)
In-Reply-To: <20150203091715.GA25445@glandium.org>
User-Agent: alot/0.3.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263315>

On Tue, 03 Feb 2015 at 10:17:15, Mike Hommey wrote:
> Symptoms:
>   $ git blame HEAD -- foo
>   fatal: no such path foo in <random garbage>
> 
> Expected output:
>   $ git blame HEAD -- foo
>   fatal: no such path foo in HEAD
> 
> Bisect says this was introduced in 1da1e07c835e900337714cfad6c32a8dc0b36ac3
> [...]

This should be fixed by commit a46442f (blame.c: fix garbled error
message, 2015-01-12) which is in next.
