From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] git-svn: don't escape tilde ('~') for http(s) URLs
Date: Wed, 22 Oct 2008 08:13:25 +0200
Organization: glandium.org
Message-ID: <20081022061325.GC8225@glandium.org>
References: <20081018213919.GC3107@atjola.homenet> <20081018224728.GD3107@atjola.homenet> <20081021211131.GA21606@yp-box.dyndns.org> <7vtzb5wr6v.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>,
	=?iso-8859-15?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	git@vger.kernel.org, jsogo@debian.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 22 08:15:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsWzo-0004Pl-Ec
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 08:15:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537AbYJVGNw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 02:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751529AbYJVGNw
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 02:13:52 -0400
Received: from vuizook.err.no ([194.24.252.247]:37896 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751501AbYJVGNv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 02:13:51 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1KsWyR-0006eQ-Tg; Wed, 22 Oct 2008 08:13:43 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1KsWyD-0002hd-Qj; Wed, 22 Oct 2008 08:13:25 +0200
Content-Disposition: inline
In-Reply-To: <7vtzb5wr6v.fsf@gitster.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98831>

On Tue, Oct 21, 2008 at 02:53:28PM -0700, Junio C Hamano wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> >> strace revealed that git-svn url-encodes ~ while svn does not do that.
> >>
> >> For svn we have:
> >> write(5, "<S:update-report send-all=\"true\" xmlns:S=\"svn:\">
> >> <S:src-path>https://sucs.org/~welshbyte/svn/backuptool/trunk</S:src-path>...
> >>
> >> While git-svn shows:
> >> write(7, "<S:update-report send-all=\"true\" xmlns:S=\"svn:\">
> >> <S:src-path>https://sucs.org/%7Ewelshbyte/svn/backuptool/trunk</S:src-path>...
> 
> This looks like an XML based request sequence to me (and svn is talking
> WebDAV here, right?);

XML based would be &126;, not %7E.
Anyways, aren't there ready-to-use url quoting functions in perl ?

Mike
