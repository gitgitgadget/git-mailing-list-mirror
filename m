From: Nicolas Pitre <nico@cam.org>
Subject: Re: two questions about the format of loose object
Date: Wed, 03 Dec 2008 19:54:26 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812031949060.14328@xanadu.home>
References: <493399B7.5000505@gmail.com> <20081201153211.GH23984@spearce.org>
 <4934A5EC.2090708@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	git list <git@vger.kernel.org>
To: Liu Yubao <yubao.liu@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 01:56:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L82Vq-0001Xl-Cr
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 01:56:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759089AbYLDAyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 19:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759638AbYLDAye
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 19:54:34 -0500
Received: from relais.videotron.ca ([24.201.245.36]:64634 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759524AbYLDAyd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 19:54:33 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KBB00MUOUIQPNP0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 03 Dec 2008 19:54:27 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <4934A5EC.2090708@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102317>

On Tue, 2 Dec 2008, Liu Yubao wrote:

> In fact the format I proposed in my patches is uncompressed loose
> object, not uncompressed loose object header, that's to say I
> proposed format 2 in my question 2, I am just curious why the
> loose object header is compressed in question 1.
> 
> I did a test to add all files of git-1.6.1-rc1 with git-add, the
> time spent decreased by half. Other commands like git diff,
> git diff --cached, git diff HEAD~ HEAD should be faster now
> although the change may be not noticable for small and medium project.

Please try this with an unmodified git version:

	git config --global core.loosecompression 0

and redo your tests please.

One thing that a purely uncompressed loose object format is missing is 
quick data integrity protection. With the above, you'll have all your 
loose objects uncompressed but they'll still have a CRC32 done over 
them.


Nicolas
