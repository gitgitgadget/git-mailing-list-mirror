From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: Importing Bzr revisions
Date: Mon, 23 Mar 2009 16:07:03 +0200
Message-ID: <87zlfcz62g.fsf@iki.fi>
References: <90DBD254-1810-4B11-AA9F-C5661A028FA5@gmail.com>
	<7veiwo8xz7.fsf@gitster.siamese.dyndns.org>
	<03AC7EDA-2A9F-4626-A67B-CE9F2A88FC7D@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	bazaar@lists.canonical.com
To: David Reitter <david.reitter@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 15:08:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Llkpg-0006HY-Gx
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 15:08:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754693AbZCWOHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 10:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754643AbZCWOHV
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 10:07:21 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:41941 "EHLO kirsi1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754543AbZCWOHU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 10:07:20 -0400
Received: from mithlond.arda.local (80.220.180.181) by kirsi1.inet.fi (8.5.014)
        id 49B910AD006AE9C5; Mon, 23 Mar 2009 16:07:04 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1Llknv-0000t5-3D; Mon, 23 Mar 2009 16:07:03 +0200
In-Reply-To: <03AC7EDA-2A9F-4626-A67B-CE9F2A88FC7D@gmail.com> (David Reitter's message of "Mon\, 23 Mar 2009 09\:27\:24 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114308>

[I'll Cc to Bazaar list too because this subject is half-Git and
half-Bazaar and we may need help from both sides.]


On 2009-03-23 09:27 (-0400), David Reitter wrote:

> I'm just experimenting with "bzr fast-export", which converts to git,
> and it seems to take about 4 minutes for 1000 revisions on our
> (modern) server. That would be around 7 hours for my emacs repository;
> I can't do that daily.
>
> I wonder if there's a way for (bzr) fast-export / (git) fast-import to
> work incrementally, i.e. for selected or most recent revisions.

They can or should work incrementally, and actually I have succesfully
done that. The idea is to use --import-marks and --export-marks options
with "git fast-import" and --marks option with "bzr fast-export.

I noticed some problems with newer versions of "bzr fast-export", though
(since it was converted to a proper Bzr command). It seems to corrupt
the marks file when doing the first incremental export after the initial
export. At least the revisions are not in right order in the marks file
anymore. "git fast-import" can't continue to import from the same
revision where it left last time and it seems to create alternative
history -- or something.

Really I don't know if this is a bug in Bzr or in Git and haven't
figured out how to file a useful bug report.
