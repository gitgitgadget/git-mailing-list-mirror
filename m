From: Junio C Hamano <gitster@pobox.com>
Subject: Re: gc considered dangerous
Date: Sun, 08 Feb 2009 23:43:00 -0800
Message-ID: <7vskmoukcb.fsf@gitster.siamese.dyndns.org>
References: <200902080347.25970.robin.rosenberg.lists@dewire.com>
 <alpine.DEB.1.00.0902081551290.10279@pacific.mpi-cbg.de>
 <7vhc34y9za.fsf@gitster.siamese.dyndns.org>
 <20090209065919.GB13257@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Git ML <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Mon Feb 09 08:44:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWQot-0001EC-Kk
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 08:44:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754044AbZBIHnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 02:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754028AbZBIHnM
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 02:43:12 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37540 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754018AbZBIHnL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 02:43:11 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0F9A2980F8;
	Mon,  9 Feb 2009 02:43:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A944A980F5; Mon,
  9 Feb 2009 02:43:02 -0500 (EST)
In-Reply-To: <20090209065919.GB13257@glandium.org> (Mike Hommey's message of
 "Mon, 9 Feb 2009 07:59:19 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4C2DD9FE-F67D-11DD-95E2-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109049>

Mike Hommey <mh@glandium.org> writes:

> On Sun, Feb 08, 2009 at 12:00:57PM -0800, Junio C Hamano wrote:
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > My preliminary guess is that this code in pack-write.c needs to use the 
>> > lock file paradigm:
>> >
>> >         if (!index_name) {
>> > 		[...]
>> >         } else {
>> >                 unlink(index_name);
>> >                 fd = open(index_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
>> >         }
>> 
>> Whoa.  That particular code has been (and is still) correct.
>
> Don't both unlink and open fail in the case the index file is locked in
> Windows ?

Read the rest of the thread and read the code.

The index_file in question is not the file git-repack is telling
pack-write.c to unlink and open.
