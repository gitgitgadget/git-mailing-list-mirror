From: Mike Hommey <mh@glandium.org>
Subject: Re: fast-import's gfi_unpack_entry causes too many munmap/mmap cycles
Date: Sat, 16 Apr 2016 18:31:46 +0900
Message-ID: <20160416093146.GA15853@glandium.org>
References: <20160416091839.GA12764@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 11:32:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arMa6-0000LM-5h
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 11:31:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbcDPJbx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2016 05:31:53 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:39368 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751214AbcDPJbx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2016 05:31:53 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1arMZu-00048t-Gm; Sat, 16 Apr 2016 18:31:46 +0900
Content-Disposition: inline
In-Reply-To: <20160416091839.GA12764@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291718>

On Sat, Apr 16, 2016 at 06:18:39PM +0900, Mike Hommey wrote:
> Now, while each individual case could be improved to avoid
> gfi_unpack_entry, it seems to me it would be better to make
> gfi_unpack_entry better somehow.

Come to think of it, there are cases that might still be worth fixing.
Like avoiding load_tree() altogether when doing `M 040000 $sha1 ` when
there is no other filemodify/filedelete following.

Mike
