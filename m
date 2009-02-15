From: Junio C Hamano <gitster@pobox.com>
Subject: Re: filter-branch: Remove original/*
Date: Sun, 15 Feb 2009 13:26:39 -0800
Message-ID: <7vvdrbie7k.fsf@gitster.siamese.dyndns.org>
References: <431341160902131845g58d99635ie0735b433802d6be@mail.gmail.com>
 <alpine.DEB.1.00.0902142219010.10279@pacific.mpi-cbg.de>
 <7vvdrblcl0.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0902152046090.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Kidd <git@randomhacks.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 15 22:28:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYoX8-0008Lo-Dm
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 22:28:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753485AbZBOV0s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 16:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753285AbZBOV0r
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 16:26:47 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39170 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655AbZBOV0q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 16:26:46 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BC49C9AAF8;
	Sun, 15 Feb 2009 16:26:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7ADBD9AAF7; Sun,
 15 Feb 2009 16:26:41 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0902152046090.10279@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Sun, 15 Feb 2009 20:47:19 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 58B6FC6C-FBA7-11DD-86DF-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110057>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Why?  Most tags will be created once and will stay there.  That is how 
>> tags are supposed to behave, isn't it?
>
> Exactly my point.  In the common case, it does not change a thing.

Wrong.

In the common case, you will create tons of useless files that waste a
disk block to store 180-byte or so perr each tag.

> However in the case that we _do_ change tags, would you not agree that the 
> reflog is _the_ place to record the change?

That merely means whoever changes the tag and wants the record of such an
update, which is uncommon, need to make sure reflog is created for that
tag (and that tag only).
