From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [RFC/PATCH] git-gui: Use gitattribute "encoding" for file content display
Date: Wed, 23 Jan 2008 09:41:23 +0100
Message-ID: <EFF72DA9-A717-44A1-9C5C-649D08BB7E96@zib.de>
References: <20080123054709.GA13166@spearce.org> <7v7ii1ozly.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	Junio C Hamano <gitster@pobox.com>,
	Michele Ballabio <barra_cuda@katamail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jan 23 09:41:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHbAb-0002cn-L0
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 09:41:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbYAWIks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 03:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbYAWIks
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 03:40:48 -0500
Received: from mailer.zib.de ([130.73.108.11]:57200 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750994AbYAWIkr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 03:40:47 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m0N8eMMf001484;
	Wed, 23 Jan 2008 09:40:22 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m0N8eL96029357
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 23 Jan 2008 09:40:21 +0100 (MET)
In-Reply-To: <7v7ii1ozly.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71521>


On Jan 23, 2008, at 6:55 AM, Junio C Hamano wrote:

> "Shawn O. Pearce" <spearce@spearce.org> writes:
>
>> git-gui: Use gitattribute "encoding" for file content display
>>
>> Most folks using git-gui on internationalized files have complained
>> that it doesn't recognize UTF-8 correctly.  In the past we have just
>> ignored the problem and showed the file contents as binary/US-ASCII,
>> which is wrong no matter how you look at it.
>
> Hmmm.
>
> At least for now in 1.5.4, I'd prefer the way gitk shows UTF-8
> (if I recall correctly latin-1 or other legacy encoding, as long
> as LANG/LC_* is given appropriately, as well) contents without
> per-path configuration without introducing new attributes.

Shouldn't we first try harder to get things right without adding
an attribute?  Maybe we could continue a good tradition and look
at the content of the first: we could first look for hints in the
file about the encoding.  XML and many text files contain such
hints already to help editors.  For example,  Python source can
explicitly contain the encoding [1]; and I guess there are many
other examples.  If we don't find a direct hint, we could have
some magic auto-detection similar to what we do for autocrlf.  As
a fallback the user could specify a default encoding.  But only
as a last resort, I'd use explicit attributes.

[1] http://www.python.org/dev/peps/pep-0263/

	Steffen
