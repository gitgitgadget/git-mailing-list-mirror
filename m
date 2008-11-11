From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 1/7] Test the origName part of the key vs the ref
	itself
Date: Tue, 11 Nov 2008 10:05:20 -0800
Message-ID: <20081111180520.GN2932@spearce.org>
References: <1226095664-13759-1-git-send-email-robin.rosenberg@dewire.com> <1226095664-13759-2-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Nov 11 19:07:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzxdN-0002sh-5U
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 19:06:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754099AbYKKSFV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 13:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754072AbYKKSFV
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 13:05:21 -0500
Received: from george.spearce.org ([209.20.77.23]:57440 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753972AbYKKSFV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 13:05:21 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 379EB381FF; Tue, 11 Nov 2008 18:05:20 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1226095664-13759-2-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100663>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> @@ -127,4 +129,12 @@ public void testDeleteEmptyDirs() throws IOException {
>  	private void assertExists(final boolean expected, final String name) {
>  		assertEquals(expected, new File(db.getDirectory(), name).exists());
>  	}
> +
> +	public void testRefKeySameAsOrigName() {
> +		Map<String, Ref> allRefs = db.getAllRefs();
> +		for (Entry<String, Ref> e : allRefs.entrySet()) {
> +			assertEquals(e.getKey(), e.getValue().getOrigName());
> +
> +		}
> +	}

Hmm, doesn't this have to go after "Keep original ref name ..."
so getOrigName() is actually defined?

-- 
Shawn.
