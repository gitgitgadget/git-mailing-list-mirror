From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Respect crlf attribute even if core.autocrlf has not
 been set
Date: Wed, 23 Jul 2008 12:35:15 -0700
Message-ID: <7vd4l4cs24.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0807222255450.8986@racer>
 <alpine.DEB.1.00.0807231817460.8986@racer> <488772BC.80207@workspacewhiz.com>
 <200807232122.38471.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 21:36:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLk8N-0004fz-Cq
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 21:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753091AbYGWTfY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 15:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbYGWTfY
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 15:35:24 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44999 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649AbYGWTfX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 15:35:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7895937D55;
	Wed, 23 Jul 2008 15:35:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A879237D54; Wed, 23 Jul 2008 15:35:17 -0400 (EDT)
In-Reply-To: <200807232122.38471.robin.rosenberg.lists@dewire.com> (Robin
 Rosenberg's message of "Wed, 23 Jul 2008 21:22:38 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7DAAD450-58EE-11DD-8810-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89755>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:

>> There are certain file formats, such as a Visual Studio .sln file, that 
>> MUST be CRLF.  When a .sln file is not CRLF, Visual Studio refuses to 
>> read it.  I want to be able to set into the committed .gitattributes 
>> file the list of files that must be translated to the proper format 
>> regardless of the autocrlf setting.  An example is below:
>> 
>> *.bat crlf
>...
>> *.vcw crlf
>
> Wouldn't  "*bat -crlf " etc be good for these, and thus store CRLF in the repo.

I'd agree.  And I do not think we would want to introduce "crlf=force"
that converts working tree files that could be LF terminated to CRLF upon
checking in.  That is as bad as some helpful editors that adds CR at the
end of line without being asked.
