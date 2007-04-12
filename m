From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [BUG] 'stg add FILE' when FILE is a symlink to dir adds dir contents
Date: Thu, 12 Apr 2007 08:58:10 +0200
Message-ID: <20070412065810.GA22949@diana.vm.bytemark.co.uk>
References: <20070411155452.GL5329@moonlight.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 08:58:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbtGC-0001qY-QH
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 08:58:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161053AbXDLG6O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 12 Apr 2007 02:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161304AbXDLG6O
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 02:58:14 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3710 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161053AbXDLG6N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 02:58:13 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HbtFz-0005zJ-00; Thu, 12 Apr 2007 07:58:11 +0100
Content-Disposition: inline
In-Reply-To: <20070411155452.GL5329@moonlight.home>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44328>

On 2007-04-11 19:54:52 +0400, Tomash Brechko wrote:

> I have no knowledge of Python, so I can't fix it myself, but perhaps
> one should check for symlink before 'if os.path.isdir(i):'.

Correct. From the Python library reference:

  isdir(path)
    Return True if path is an existing directory. This follows
    symbolic links, so both islink() and isdir() can be true for the
    same path.

So, os.path.islink() would be the function to use.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
