From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-import: add ignore non-existent files option.
Date: Tue, 02 Sep 2008 00:36:21 -0700
Message-ID: <7v8wubm22y.fsf@gitster.siamese.dyndns.org>
References: <94a0d4530809011501n651c42c8xebb5cc39a93aac4c@mail.gmail.com>
 <1220308173-20392-1-git-send-email-felipe.contreras@gmail.com>
 <20080901223802.GK7482@spearce.org>
 <94a0d4530809011552h59e476e0q9033f0b917288a8f@mail.gmail.com>
 <20080902043951.GB13248@spearce.org>
 <7vfxojrvvp.fsf@gitster.siamese.dyndns.org>
 <20080902053503.GD13248@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Sep 02 09:37:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaQSV-0001hq-MB
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 09:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752782AbYIBHgb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 03:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752449AbYIBHgb
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 03:36:31 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59413 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092AbYIBHga (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 03:36:30 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 87CA270ED3;
	Tue,  2 Sep 2008 03:36:28 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id F02AB70ED2; Tue,  2 Sep 2008 03:36:23 -0400 (EDT)
In-Reply-To: <20080902053503.GD13248@spearce.org> (Shawn O. Pearce's message
 of "Mon, 1 Sep 2008 22:35:03 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DAC308E0-78C1-11DD-85A0-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94662>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> I think selective loosening of consistency check makes sense very much,
>> but I have been wondering if these should be command line options.
>> 
>> The only example we saw so far is about output from one exporter.  Perhaps
>> it should be given to fast-import as initial set of commands ("#pragma"!)
>> that describes the nature of the input file?
>
> Yea, I briefly considered that when I added the timestamp format
> option.  I didn't bother because it was a single option and I figured
> most frontends start git-fast-import directly.  But with this being
> added a "format pragrma header thingy" makes a lot of sense.

Oh, I did not mean to suggest hiding it as a comment to silently allow
older fast-import slurp such input and produce broken results.

For input that needs such loosened error checking, old fast-import won't
produce correct results _anyway_, so I would agree that making these
things into explicit commands to cause older fast-import to error out
would make a lot more sense.
