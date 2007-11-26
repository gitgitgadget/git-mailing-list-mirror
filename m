From: Sergei Organov <osv@javad.com>
Subject: Re: [PATCH] Don't add To: recipients to the Cc: header
Date: Mon, 26 Nov 2007 21:29:11 +0300
Message-ID: <8763zoq2rs.fsf@osv.gnss.ru>
References: <1195470026-7389-1-git-send-email-ask@develooper.com>
	<7vr6ill5f1.fsf@gitster.siamese.dyndns.org>
	<7A3DDFA5-085D-4D92-BE96-A405FF1FB029@develooper.com>
	<7v8x4slovk.fsf@gitster.siamese.dyndns.org>
	<87ejekzpx3.fsf@osv.gnss.ru>
	<7vr6ikk6rf.fsf@gitster.siamese.dyndns.org>
	<87lk8orgpm.fsf@osv.gnss.ru>
	<7vejegu4in.fsf@gitster.siamese.dyndns.org>
	<87hcjcra10.fsf@osv.gnss.ru>
	<7vejegsejz.fsf@gitster.siamese.dyndns.org>
	<87wss5p177.fsf@osv.gnss.ru>
	<7v3autgd8q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ask =?utf-8?Q?Bj=C3=B8rn?= Hansen <ask@develooper.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 19:34:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iwimq-0006wn-8r
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 19:34:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752541AbXKZSeF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 13:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbXKZSeE
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 13:34:04 -0500
Received: from javad.com ([216.122.176.236]:3524 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752055AbXKZSeD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 13:34:03 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id lAQITHH32132;
	Mon, 26 Nov 2007 18:29:19 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1Iwihj-0003mi-Cj; Mon, 26 Nov 2007 21:29:11 +0300
In-Reply-To: <7v3autgd8q.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Mon\, 26 Nov 2007 08\:53\:09 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66089>

Junio C Hamano <gitster@pobox.com> writes:

> Sergei Organov <osv@javad.com> writes:
>
>>> GNU folks even managed to insert text that allows a completely empty
>>> line (not a line with a single SP on it) to express a context line
>>> that is empty, which means...
>>
>> Really? That's a surprise for me. What I can tell for sure, Emacs' diff
>> mode doesn't support this, as it does interpret plain empty line as a
>> hunk delimiter, at least in Emacs 22.1.
>
> See b507b465f7831612b9d9fc643e3e5218b64e5bfa (git-apply: prepare for
> upcoming GNU diff -u format change).  Around the time that eventually
> lead to this commit (mid October 2006) there was a discussion on this
> mailing list on the issue, too.  I do not doubt you checked with your
> version of Emacs diff mode that it does not support this yet, but it's
> only prudent to assume that a new version someday will.

Thanks, -- it was interesting to read corresponding discussions.

Due to this change in GNU diff, it seems that empty line is indeed a
wrong choice for syntactic hunk separator :( I wonder if there is a
common way to say "here the patch ends" then[1]? My best guess is that

===

will do.

[1] I've checked bzr and hg. Bzr uses empty line for that (followed by
"# Begin bundle" line) in their "merge directive" format. Not
Emacs-friendly either :( Hg's "export" just EOFs after the patch.

-- 
Sergei.
