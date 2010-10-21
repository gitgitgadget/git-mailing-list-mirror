From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv4 05/21] notes.h/c: Clarify the handling of notes objects that are == null_sha1
Date: Thu, 21 Oct 2010 15:13:05 +0200
Message-ID: <201010211513.06176.johan@herland.net>
References: <1287626936-32232-1-git-send-email-johan@herland.net> <1287626936-32232-6-git-send-email-johan@herland.net> <20101021051232.GA2413@burratino>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, bebarino@gmail.com, avarab@gmail.com,
	gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 15:14:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8uy1-0006ee-Nt
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 15:14:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757158Ab0JUNN4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 09:13:56 -0400
Received: from smtp.opera.com ([213.236.208.81]:51547 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755284Ab0JUNNz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 09:13:55 -0400
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o9LDD6SO008090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 21 Oct 2010 13:13:06 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <20101021051232.GA2413@burratino>
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.64 on 213.236.208.81
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159501>

On Thursday 21 October 2010, Jonathan Nieder wrote:
> Johan Herland wrote:
> > Clearly specify how combine_notes functions are expected to handle
> > null_sha1 in input. Also specify (and implement) that returning
> > null_sha1 from a combine_notes function will cause the note in
> > question to be removed.
>
> Ack again on patches 1-4.  As for this one, I still think the log
> message does not make the goal obvious.
>
> [...]

Ok, I liked your alternative message much better. The next iteration 
will have this commit message:

  notes.h/c: Allow combine_notes functions to remove notes

  Allow combine_notes functions to request that a note be removed,
  by setting the resulting note SHA1 to null_sha1 (0000000...).

  For consistency, also teach note_tree_insert() to skip insertion
  of an empty note when there is no note to combine it with.

  In general, an empty note is treated identically to no note at
  all, but when adding an empty note where there already exists a
  non-empty note, we allow the combine_notes function to potentially
  record a new/changed note. Document this behaviour, and clearly
  specify how combine_notes functions are expected to handle null_sha1
  in input.


Thanks again, for your superhuman patience in reviewing.

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
