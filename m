From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH] Support for delegating tree iterators
Date: Thu, 2 Jul 2009 22:00:39 +0200
Message-ID: <200907022200.40179.robin.rosenberg.lists@dewire.com>
References: <1246470772-4496-1-git-send-email-constantine.plotnikov@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Constantine Plotnikov <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 02 22:01:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMSSn-0006Ce-3Q
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 22:00:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753779AbZGBUAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2009 16:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752988AbZGBUAn
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 16:00:43 -0400
Received: from mail.dewire.com ([83.140.172.130]:15465 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752789AbZGBUAn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2009 16:00:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 9D0DC139B909;
	Thu,  2 Jul 2009 22:00:41 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6PMGtDXBL30y; Thu,  2 Jul 2009 22:00:41 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.6])
	by dewire.com (Postfix) with ESMTP id 29F39139B8FB;
	Thu,  2 Jul 2009 22:00:41 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <1246470772-4496-1-git-send-email-constantine.plotnikov@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122668>

onsdag 01 juli 2009 19:52:52 skrev Constantine Plotnikov <constantine.plotnikov@gmail.com>:
> +	protected void ensurePathCapacity(final int capacity, final int len) {
> +		if(path.length >= capacity) {
> +			return;
> +		}
> +		final byte[] o = path;
> +		int current = o.length;
> +		int newCapacity = current;
> +		while(newCapacity < capacity && newCapacity > 0) {
> +			newCapacity <<= 1;
> +		}
> +		setPathCapacity(newCapacity, len);
> +	}

There are no JUnit tests that directly or indirectly proves this is working as only
the optimized path is taken.


> +	public int getNameLength() {
> +		return pathLen - pathOffset;
> +	}

> +	public void getName(byte[] buffer, int offset) {
> +		System.arraycopy(path, pathOffset, buffer, offset, pathLen - pathOffset);
> +	}

Never used? Not even unit test code.

> -- robin
