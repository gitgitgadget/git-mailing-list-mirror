From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Interaction between clean/smudge and git status
Date: Mon, 14 Apr 2008 00:04:35 -0700
Message-ID: <7vej98apdo.fsf@gitster.siamese.dyndns.org>
References: <loom.20080413T231611-113@post.gmane.org>
 <4802FE3C.4090306@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sergio Callegari <sergio.callegari@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Apr 14 09:06:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlIkp-0007lZ-62
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 09:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755185AbYDNHEn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 03:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755343AbYDNHEn
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 03:04:43 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37258 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755103AbYDNHEm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 03:04:42 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6AA863811;
	Mon, 14 Apr 2008 03:04:41 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id BB14E3810; Mon, 14 Apr 2008 03:04:37 -0400 (EDT)
In-Reply-To: <4802FE3C.4090306@viscovery.net> (Johannes Sixt's message of
 "Mon, 14 Apr 2008 08:48:28 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79475>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Sergio Callegari schrieb:
>> I have tried for the first time the .gitattributes filter option, setting a
>> clean and a smudge filter for a certain type of files.
>> 
>> What makes me wonder is that using filters, after a clean checkout git status
>> says that everything is changed.

What is to "re-zip"?  You have a .zip file that contains a single file in
your work tree, and the index and the tree objects record that single file
deflated?  When you "check out" from the index, you run smudge to create a
new .zip file with that single file?

>> Is this the expected behaviour of the smudge filter?
>
> I've observed this, too, and I don't think it is expected behavior. But it
> hasn't annoyed me enough to look at it in depth. Eventually I will, and I
> hope to find out what's wrong. ;)

Are you recreating the .zip file in the filter in such a way that a file
with the same contents results in byte-to-byte identical .zip file?
Otherwise as far as git is concerned you have changed the file in the work
tree.
