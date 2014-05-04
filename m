From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 1/9] Define a structure for object IDs.
Date: Sun, 04 May 2014 11:43:20 +0200
Message-ID: <878uqhvpzb.fsf@fencepost.gnu.org>
References: <1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net>
	<1399147942-165308-2-git-send-email-sandals@crustytoothpaste.net>
	<5365D91E.70207@alum.mit.edu> <536606AB.1020803@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun May 04 12:16:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgtSo-0008GF-OR
	for gcvg-git-2@plane.gmane.org; Sun, 04 May 2014 12:16:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753498AbaEDKQB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2014 06:16:01 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:36804 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276AbaEDKQA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2014 06:16:00 -0400
Received: from localhost ([127.0.0.1]:35844 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WgtSh-0001H5-9f; Sun, 04 May 2014 06:15:59 -0400
Received: by lola (Postfix, from userid 1000)
	id 37449E08CF; Sun,  4 May 2014 11:43:20 +0200 (CEST)
In-Reply-To: <536606AB.1020803@kdbg.org> (Johannes Sixt's message of "Sun, 04
	May 2014 11:21:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248088>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 04.05.2014 08:07, schrieb Michael Haggerty:
>> On 05/03/2014 10:12 PM, brian m. carlson wrote:
>>> Introduce a structure for object IDs.  This allows us to obtain the benefits
>>> of compile-time checking for misuse.  The structure is expected to remain
>>> the same size and have the same alignment requirements on all known
>>> platforms, compared to the array of unsigned char.
>>
>> Please clarify whether you plan to rely on all platforms having "the
>> same size and alignment constraints" for correctness, or whether that
>> observation of the status quo is only meant to reassure us that this
>> change won't cause memory to be wasted on padding.
>
> I think that a compiler that has different size and alignment
> requirements for the proposed struct object_id and an unsigned
> char[20] would, strictly speaking, not be a "C" compiler.

Huh?  How so?  There is no warranty as far as I know that a structure
with only a single member has the same size and alignment requirements
as the single member would have.  There is also no guarantee as far as I
know that anything but element dereference is a valid means of
converting access to a struct to access to a sole element.

-- 
David Kastrup
