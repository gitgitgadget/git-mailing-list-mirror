From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Supplant the "while case ... break ;; esac" idiom
Date: Mon, 24 Sep 2007 09:57:31 +0200
Message-ID: <86ejgowl5g.fsf@lola.quinscape.zz>
References: <853ax5mb1j.fsf@lola.goethe.zz> <85myvdktb3.fsf@lola.goethe.zz>
	<20070924060521.GB10975@glandium.org> <85k5qgk295.fsf@lola.goethe.zz>
	<ee77f5c20709232330n7b47d9e9v38677678dbf197da@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 24 09:57:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZipE-0002Ky-6E
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 09:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbXIXH5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 03:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753456AbXIXH5q
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 03:57:46 -0400
Received: from main.gmane.org ([80.91.229.2]:53133 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751032AbXIXH5p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 03:57:45 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IZip0-0006xy-F4
	for git@vger.kernel.org; Mon, 24 Sep 2007 07:57:38 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 24 Sep 2007 07:57:38 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 24 Sep 2007 07:57:38 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:KtDdR2R3Nj52HfGrWL4kckh8WPM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59026>

"David Symonds" <dsymonds@gmail.com> writes:

> On 24/09/2007, David Kastrup <dak@gnu.org> wrote:
>> Mike Hommey <mh@glandium.org> writes:
>>
>> > On Sun, Sep 23, 2007 at 10:42:08PM +0200, David Kastrup wrote:
>> >> -while case $# in 0) break ;; esac
>> >> +while test $# != 0
>> >
>> > Wouldn't -ne be better ?
>>
>> Why?
>
> Because -ne does a numeric comparison, != does a string comparison,
> and it's a numeric comparison happening, semantically speaking.

I don't see the point in converting $# and 0 into numbers before
comparing them.  "!=" is quite more readable, and the old code also
compared the strings.

-- 
David Kastrup
