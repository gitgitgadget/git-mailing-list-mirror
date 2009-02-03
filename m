From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] http-push.c: get_remote_object_url() is only used
	under USE_CURL_MULTI
Date: Tue, 3 Feb 2009 07:54:57 +0100
Organization: glandium.org
Message-ID: <20090203065457.GA8466@glandium.org>
References: <7v8woodnmj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Tay Ray Chuan <rctay89@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 07:56:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUFD4-00082p-IJ
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 07:56:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042AbZBCGzN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 01:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752041AbZBCGzM
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 01:55:12 -0500
Received: from vuizook.err.no ([85.19.221.46]:39960 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751735AbZBCGzL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 01:55:11 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1LUFBV-0003Rx-68; Tue, 03 Feb 2009 07:55:03 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1LUFBR-0002Dx-2s; Tue, 03 Feb 2009 07:54:57 +0100
Content-Disposition: inline
In-Reply-To: <7v8woodnmj.fsf@gitster.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108157>

On Mon, Feb 02, 2009 at 10:45:56PM -0800, Junio C Hamano wrote:
> Otherwise -Wunused-function (which is implied by -Wall) triggers.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
> I think this patch is probably a bit on the wrong side of the borderline,
> in that it *happens to be* that get_remote_object_url() is used by nobody
> in non-multi codepath right now, but it is entirely possible that future
> code clean-up can benefit from its use.  But without this patch,, the file
> does not compile for me (I compile everything with "-Werror -Wall").

If I recall correctly, http-push just doesn't work without curl-multi,
so the correct fix would be to just disable http-push when
USE_CURL_MULTI is undefined.

Mike
