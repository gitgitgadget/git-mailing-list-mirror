From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/9] Make gitexecdir relative to $(bindir) on Windows
Date: Wed, 23 Jul 2008 11:28:50 -0700
Message-ID: <7vmyk8e9p9.fsf@gitster.siamese.dyndns.org>
References: <1216667998-8879-1-git-send-email-johannes.sixt@telecom.at>
 <alpine.DEB.1.00.0807220140170.3407@eeepc-johanness>
 <200807222131.32828.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Wed Jul 23 20:30:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLj68-0003Cs-52
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 20:30:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753351AbYGWS27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 14:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753302AbYGWS26
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 14:28:58 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61856 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909AbYGWS25 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 14:28:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 895D538D05;
	Wed, 23 Jul 2008 14:28:56 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 63F7338D03; Wed, 23 Jul 2008 14:28:52 -0400 (EDT)
In-Reply-To: <200807222131.32828.johannes.sixt@telecom.at> (Johannes Sixt's
 message of "Tue, 22 Jul 2008 21:31:32 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 35DEC428-58E5-11DD-BF74-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89729>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> On Dienstag, 22. Juli 2008, Johannes Schindelin wrote:
>> Hi,
>>
>> On Mon, 21 Jul 2008, Johannes Sixt wrote:
>> > The problem was that argv[0] does not have a path in certain cases.
>>
>> Note that the same holds true for Linux when calling a program that is in
>> the PATH:
>
> Oh, boy!
>
>> I imagine that the proper solution would be to rip out lookup_prog() and
>> use it for non-Windows Git, too.  Unless you want to limit the usefulness
>> of your patch series to Windows, that is.
>
> This certainly goes beyond what I am prepared to do. It is not my itch. The 
> series is already much longer than I wanted, when there is a much simpler 
> solution that solves *my* problem: to set bindir = $(gitexecdir).

If you are living in the Windows world, perhaps you could record the
installation location in resource somewhere from the installer and look it
up at runtime?  Or is it considered a bad practice?
