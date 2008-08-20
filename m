From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH 2/2] Honor ~/.ssh/config whenever possible during SSH based transport
Date: Wed, 20 Aug 2008 22:34:05 +0200
Message-ID: <200808202234.08348.robin.rosenberg.lists@dewire.com>
References: <1218821705-2631-1-git-send-email-spearce@spearce.org> <1218821705-2631-2-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 20 22:36:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVuQ6-0000qj-OU
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 22:36:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754114AbYHTUfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 16:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753573AbYHTUfi
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 16:35:38 -0400
Received: from av6-1-sn3.vrr.skanova.net ([81.228.9.179]:50639 "EHLO
	av6-1-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430AbYHTUfi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 16:35:38 -0400
Received: by av6-1-sn3.vrr.skanova.net (Postfix, from userid 502)
	id 78359385E4; Wed, 20 Aug 2008 22:35:36 +0200 (CEST)
Received: from smtp3-2-sn3.vrr.skanova.net (smtp3-2-sn3.vrr.skanova.net [81.228.9.102])
	by av6-1-sn3.vrr.skanova.net (Postfix) with ESMTP
	id 45ED137F19; Wed, 20 Aug 2008 22:35:36 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-2-sn3.vrr.skanova.net (Postfix) with ESMTP id 2C68237E44;
	Wed, 20 Aug 2008 22:35:35 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1218821705-2631-2-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93038>

fredagen den 15 augusti 2008 19.35.05 skrev Shawn O. Pearce:
> +	private void addIdentity(final File identityFile)
> +			throws JSchException {
> +		final String path = identityFile.getAbsolutePath();
> +		if (loadedIdentities.add(path))
> +			provider.getJSch().addIdentity(path);
>  	}

Ok, this breaks 3.3 compatibility and I accidentally pushed it to master. Now Marek also
has stuff that only works (well) with 3.4 becaujse of bugs in 3.3, that won't be fixed. So maybe
we'd better skip 3.3 in order to work faster. I.e. I won't revert this commit, but I am willing to
accept a patch to "fix" it in order to prolong 3.3 compatibilty.

-- robin
