From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Make repack less likely to corrupt repository
Date: Wed, 11 Feb 2009 01:27:17 +0100
Message-ID: <200902110127.18149.robin.rosenberg.lists@dewire.com>
References: <1234140299-29785-1-git-send-email-robin.rosenberg@dewire.com> <200902110051.20975.robin.rosenberg.lists@dewire.com> <7vd4dpkfr2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	spearce@spearce.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 01:28:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX2y8-0007S9-Co
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 01:28:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755599AbZBKA1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 19:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755455AbZBKA1V
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 19:27:21 -0500
Received: from mail.dewire.com ([83.140.172.130]:13356 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755398AbZBKA1V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 19:27:21 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 8C588147E8AF;
	Wed, 11 Feb 2009 01:27:19 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bZ1I1UdbLA36; Wed, 11 Feb 2009 01:27:19 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 171B5803219;
	Wed, 11 Feb 2009 01:27:19 +0100 (CET)
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; i686; ; )
In-Reply-To: <7vd4dpkfr2.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109361>

onsdag 11 februari 2009 00:56:49 skrev Junio C Hamano:
> We failed to honor what the end user wanted: to repack.  Why should we
> exit 0 here?

A repack may or may not yield a better packed repo. In this case, not, but for a
different reason than failing to find better deltas. Given the circumstances that is 
most likely to cause the "failure  (repacking on windows), this is "normal" behaviour
and no reason to scare the user with an error code. The unlink error might be
enough. I think scripts should be able to continue too. The alternative would
be to have a switch to repack that scripts and UI's could enable, like -q for "don't
flag malign errors", or the other way, a --pedantic for "flag failure to make object database smaller".

-- robin
