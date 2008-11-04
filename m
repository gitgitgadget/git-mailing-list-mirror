From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH v2 1/3] t7700: demonstrate mishandling of objects in packs
 with a .keep file
Date: Tue, 04 Nov 2008 13:49:41 -0600
Message-ID: <V78jOMhdYwpSlLU-YzsqEHZxJyrvKbXRQbKsuNPZOEtB8E0kZ5Wi7Q@cipher.nrlssc.navy.mil>
References: <20081103161202.GJ15463@spearce.org> <muOuA1nLBoljLnZoguxeFeKt-8Q-I9Y3ljvxnLWLt9KyA8HwVtMa4Q@cipher.nrlssc.navy.mil> <49109FD4.30003@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Nov 04 20:51:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxRw5-0003dN-HG
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 20:51:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753570AbYKDTuT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 14:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753517AbYKDTuT
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 14:50:19 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:42933 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753425AbYKDTuS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 14:50:18 -0500
Received: by mail.nrlssc.navy.mil id mA4JnfUh004693; Tue, 4 Nov 2008 13:49:41 -0600
In-Reply-To: <49109FD4.30003@op5.se>
X-OriginalArrivalTime: 04 Nov 2008 19:49:41.0393 (UTC) FILETIME=[7A51F010:01C93EB6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100099>

Andreas Ericsson wrote:
> Brandon Casey wrote:
>> From: Brandon Casey <drafnel@gmail.com>
>>
>> Objects residing in pack files that have an associated .keep file are not
>> supposed to be repacked into new pack files, but they are.
>>
>> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
>> ---
>>
>>
>> This version replaces the use of 'head -n -1' with a grep, and should
>> work on
>> all platforms.
>>
> 
> sed 1q is faster, as it stops parsing after the first line (the same as
> 'head
> -n 1' does, but in a more portable fashion).

Except that I wanted all but the _last_ line though.

I didn't think about using sed. Perhaps I could have used something like

   sed -n -e '$q' -e 'p'

The grep works though.

-brandon
