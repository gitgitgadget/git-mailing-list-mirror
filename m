From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH v8 2/4] cat-file: teach cat-file a '--literally' option
Date: Sun, 19 Apr 2015 01:28:07 +0100
Message-ID: <20150419002807.GA11634@hashpling.org>
References: <552E9816.6040502@gmail.com>
 <1429117174-4968-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 19 02:35:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjdDF-0006Bh-8x
	for gcvg-git-2@plane.gmane.org; Sun, 19 Apr 2015 02:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924AbbDSAfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2015 20:35:47 -0400
Received: from avasout05.plus.net ([84.93.230.250]:37300 "EHLO
	avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879AbbDSAfr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2015 20:35:47 -0400
X-Greylist: delayed 454 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Apr 2015 20:35:46 EDT
Received: from hashpling.plus.com ([212.159.69.125])
	by avasout05 with smtp
	id HcU81q0012iA9hg01cU9Ck; Sun, 19 Apr 2015 01:28:11 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=O8+3vXNW c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=EBOSESyhAAAA:8
 a=0Bzu9jTXAAAA:8 a=J0QyKEt1u0cA:10 a=BHUvooL90DcA:10 a=kj9zAlcOel0A:10
 a=Ew9TdX-QAAAA:8 a=e9J7MTPGsLIA:10 a=RUrfK-ucrQtcUBz_DwYA:9 a=CjuIK1q_8ugA:10
Received: from charles by hashpling.plus.com with local (Exim 4.84)
	(envelope-from <charles@hashpling.plus.com>)
	id 1Yjd5j-000335-W8; Sun, 19 Apr 2015 01:28:07 +0100
Content-Disposition: inline
In-Reply-To: <1429117174-4968-1-git-send-email-karthik.188@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267429>

On Wed, Apr 15, 2015 at 10:29:34PM +0530, Karthik Nayak wrote:
> Currently 'git cat-file' throws an error while trying to
> print the type or size of a broken/corrupt object. This is
> because these objects are usually of unknown types.
> 
> Teach git cat-file a '--literally' option where it prints
> the type or size of a broken/corrupt object without throwing
> an error.

I'm sorry to come in with such a fundamental question at such a late
revision of this patch series, but am I the only person to wonder about
the choice of option name?

To me, cat-file already output objects "literally" (without -p) as
opposed to show. From the description, it feels more like it should be
"--unchecked" or perhaps something better that I haven't thought of?

The option isn't a true opposite of hash-object's --literally because
that also allows the creation of known types with invalid contents (e.g.
corrupt trees) whereas cat-file is quite happy to show the _contents_ of
such corrupt objects even without --literally.

Charles.
