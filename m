From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] rebase -i: redo tasks that die during cherry-pick
Date: Wed, 29 Apr 2015 01:17:39 +0200
Organization: gmx
Message-ID: <42512fad738e0ec47a8cdb6e6e92e994@www.dscho.org>
References: <1430261720-9051-1-git-send-email-hordp@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, phil.hord@gmail.com,
	Fabian Ruch <bafain@gmail.com>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 01:17:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnElC-00035T-Od
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 01:17:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031167AbbD1XRq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 19:17:46 -0400
Received: from mout.gmx.net ([212.227.17.21]:49898 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031051AbbD1XRq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 19:17:46 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LrZOj-1ZHSGX2dUT-013JhG; Wed, 29 Apr 2015 01:17:40
 +0200
In-Reply-To: <1430261720-9051-1-git-send-email-hordp@cisco.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:JGhb2hroua5uqnA8rbcJ5hmPfmjYjC7n6gktVKKr6Jy31BU0eQi
 xdkL2BQTXNYJSTOMhgxMXoK7BsZSZqDfwo1jzrRITs7mZHfGOIoS9AX3dLlfIGPEyBpnm3b
 y+VQtB1XGgh3ddikQfmadepAKxnscCT1tj+fZCJ/LjocbPddXDBw7Zsp3MlZdMBhwKqxE7b
 gE5MSZBf6/m+RPtk+FJcA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267949>

Hi,

On 2015-04-29 00:55, Phil Hord wrote:
> When rebase--interactive processes a task, it removes the item from
> the todo list and appends it to another list of executed tasks. If a
> pick (this includes squash and fixup) fails before the index has
> recorded the changes, take the corresponding item and put it on the todo
> list again. Otherwise, the changes introduced by the scheduled commit
> would be lost.
> 
> That kind of decision is possible since the cherry-pick command
> signals why it failed to apply the changes of the given commit. Either
> the changes are recorded in the index using a conflict (return value 1)
> and rebase does not continue until they are resolved or the changes
> are not recorded in the index (return value neither 0 nor 1) and
> rebase has to try again with the same task.
> 
> Add a test cases for regression testing to the "rebase-interactive"
> test suite.
> 
> Signed-off-by: Fabian Ruch <bafain@gmail.com>
> Signed-off-by: Phil Hord <hordp@cisco.com>
> ---

ACK.

It would be even nicer to avoid removing the task from the `todo` list until it has been performed correctly, of course, but I believe that would require a much more invasive patch. So this here patch is fine with me.

Ciao,
Dscho
