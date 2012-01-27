From: David Barr <davidbarr@google.com>
Subject: Re: commit/from command in git-fast-import
Date: Sat, 28 Jan 2012 01:00:17 +1100
Message-ID: <CAFfmPPPYc=9BdwuE+ANiHKrFk+_7aXDgnMv3fHxVmF0ttZu8bA@mail.gmail.com>
References: <20120127124837.GA24084@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Jan 27 15:00:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqmLp-0005ju-7h
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 15:00:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754949Ab2A0OAT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Jan 2012 09:00:19 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:55344 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474Ab2A0OAS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Jan 2012 09:00:18 -0500
Received: by yenm6 with SMTP id m6so779227yen.19
        for <git@vger.kernel.org>; Fri, 27 Jan 2012 06:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:x-system-of-record:content-type:content-transfer-encoding;
        bh=k44BmMORaES8fEmPHPv2Cadue1XPPZ4wbs5UaQBgXpY=;
        b=uykqwNomVdOYK2OmlT5GvkH5L9Q65iGEgocuJIlidycg+ZZmrJdRCjIIXrCRdXgwia
         JG8iHcWtuC7obgqbjk9ouebKDtOKC1TAdJVeAsCyRe4gaH8qo/RhrAqHlB0qcNtptrEn
         eG/+/ANKdajbqOrSuN9sl5YUcXefKOQX0LDfY=
Received: by 10.236.73.129 with SMTP id v1mr10616056yhd.129.1327672817955;
        Fri, 27 Jan 2012 06:00:17 -0800 (PST)
Received: by 10.236.73.129 with SMTP id v1mr10616030yhd.129.1327672817838;
 Fri, 27 Jan 2012 06:00:17 -0800 (PST)
Received: by 10.101.144.22 with HTTP; Fri, 27 Jan 2012 06:00:17 -0800 (PST)
In-Reply-To: <20120127124837.GA24084@glandium.org>
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189220>

On Fri, Jan 27, 2012 at 11:48 PM, Mike Hommey <mh@glandium.org> wrote:
> When I do create a commit on a given branch with a stream like:
> =A0commit refs/heads/branch
> =A0author ...
> =A0committer ...
> =A0data <<EOF
> =A0Commit message
> =A0EOF
> =A0deleteall
>
> All I get is this warning:
> =A0warning: Not updating refs/heads/branch (new tip new_sha1
> does not contain old_sha1)
>
> And the branch only has one commit, which is the one I just created.
> On the other hand, if I add a "from" instruction in the above stream,
> I have the expected branch history.

This is precisely the expected behavior.
If 'from' is omitted, the resulting commit has no preceding history.
On the other hand, what you want is to specify the parent so that
there is a continuation of history.

I hope this helps.
--
David Barr
