From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] Use exit 1 instead of die when req_Root fails.
Date: Wed, 17 Oct 2007 17:39:47 +0200
Message-ID: <8c5c35580710170839l4b31a4fao5b41efafc5a83883@mail.gmail.com>
References: <20071017140547.GA21691@Hermes.cust.hotspot.t-mobile.com>
	 <118833cc0710170739i179e7389k1e44f70086ca88be@mail.gmail.com>
	 <DC3D43FD-F03D-4E0A-9C2B-DE56F9C16D60@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Morten Welinder" <mwelinder@gmail.com>, git@vger.kernel.org,
	spearce@spearce.org
To: "Brian Gernhardt" <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 17:40:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiB06-0000EZ-1a
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 17:40:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758765AbXJQPju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 11:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758637AbXJQPju
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 11:39:50 -0400
Received: from nz-out-0506.google.com ([64.233.162.239]:19266 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758765AbXJQPjt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 11:39:49 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1545537nze
        for <git@vger.kernel.org>; Wed, 17 Oct 2007 08:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=0nwA4hZspzcmvZSPKPX0k0Gofg6AhM4i3eugku/Or94=;
        b=B+uNuS/drEJe/p9cgVhs+JS00Hko4QTHqUvhx1r5DMR7ncG2ICxi8PrljqLSBI4nIAQY06N1tzuG0KOFHCgSMU1mzwzBiMF2BieqBbSbcItk7pG8P3NaatN7QMS4UIE3zJ2A+jlbCCB+LNBbjjetRCQGrqXjtJxyRg4yBDVjtH0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jbQjuaM6Fr+XZo6SZG/9Hl2qtJgTKvsX4OPeloVyHPfi3gHlcdGu3UkXcZJ6Q6qTXZr/O3nZoacArUxDrPsFH8WYn7edi3OYXIRvPjgq8oP4wHvtB3KnKyOLcABSUut9twCFi+bByaVxzokdqYzD5Y86vWRnHgA7WTSTAYpmBvM=
Received: by 10.114.254.1 with SMTP id b1mr9962778wai.1192635587537;
        Wed, 17 Oct 2007 08:39:47 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Wed, 17 Oct 2007 08:39:47 -0700 (PDT)
In-Reply-To: <DC3D43FD-F03D-4E0A-9C2B-DE56F9C16D60@silverinsanity.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61384>

On 10/17/07, Brian Gernhardt <benji@silverinsanity.com> wrote:
> The problem is that die can exit with varying exit codes, and exit
> codes >= 128 make the test suite assume something has gone wrong with
> the test.

This makes me wonder: what about all the other instances of die() in
git-cvsserver? Or in any of the other perl scripts, for that matter?
Should they all be fixed, or is it this particular test that is wrong?

-- 
larsh
