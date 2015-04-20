From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH v8 2/4] cat-file: teach cat-file a '--literally' option
Date: Mon, 20 Apr 2015 08:44:34 +0100
Message-ID: <20150420074433.GA30422@hashpling.org>
References: <552E9816.6040502@gmail.com>
 <1429117174-4968-1-git-send-email-karthik.188@gmail.com>
 <20150419002807.GA11634@hashpling.org>
 <xmqq7ft7nz8l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karthik Nayak <karthik.188@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"sunshine@sunshineco.com" <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 09:52:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yk6V9-0004sV-IT
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 09:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753599AbbDTHwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 03:52:16 -0400
Received: from avasout06.plus.net ([212.159.14.18]:41707 "EHLO
	avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327AbbDTHwO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 03:52:14 -0400
X-Greylist: delayed 455 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Apr 2015 03:52:13 EDT
Received: from hashpling.plus.com ([212.159.69.125])
	by avasout06 with smtp
	id J7ka1q0012iA9hg017kbP8; Mon, 20 Apr 2015 08:44:37 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=QqHQ3DCd c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=EBOSESyhAAAA:8
 a=0Bzu9jTXAAAA:8 a=J0QyKEt1u0cA:10 a=BHUvooL90DcA:10 a=kj9zAlcOel0A:10
 a=Ew9TdX-QAAAA:8 a=e9J7MTPGsLIA:10 a=ybZZDoGAAAAA:8 a=MwliW8fC2QeNGXy3JI4A:9
 a=CjuIK1q_8ugA:10
Received: from charles by hashpling.plus.com with local (Exim 4.84)
	(envelope-from <charles@hashpling.plus.com>)
	id 1Yk6Ne-0007vI-5y; Mon, 20 Apr 2015 08:44:34 +0100
Content-Disposition: inline
In-Reply-To: <xmqq7ft7nz8l.fsf@gitster.dls.corp.google.com>
X-Apple-Message-Smime-Encrypt: NO
X-Apple-Notify-Thread: NO
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267456>

> On 20 Apr 2015, at 06:30, Junio C Hamano <gitster@pobox.com> wrote:
> Charles Bailey <charles@hashpling.org> writes:
> 
>> The option isn't a true opposite of hash-object's --literally because
>> that also allows the creation of known types with invalid contents (e.g.
>> corrupt trees) whereas cat-file is quite happy to show the _contents_ of
>> such corrupt objects even without --literally.
> 
> Not really.  If you create an object with corrupt type string (e.g. "BLOB"
> instead of "blob"), cat-file would not be happy.

Sorry, the emphasis should have been on "complete" of "complete
opposite".  There are some types of bad objects that can be created only
with hash-object --literally (malformed tag or tree), for which cat-file
works with fine and there are other types (pun unintended - BLOB,
wobble, etc.) for which --literally/--unchecked is required with
cat-file.

So I meant that cat-file's --literally is only a partial "opposite" or
analogue of hash-object's.

--allow-invalid-types? --force (in the sense of "suppress some possible
errors")? It's not a big thing but I'm aware that if we can find a better
name then now would be the best moment. If not, then --literally it is.
