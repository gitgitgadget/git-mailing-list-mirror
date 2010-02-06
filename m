From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [RFC/PATCH] rebase: add -x option to record original commit name
Date: Fri, 5 Feb 2010 23:18:45 -0500
Message-ID: <76718491002052018s324747ecj31963b493868dbbd@mail.gmail.com>
References: <1265419166-21388-1-git-send-email-jaysoffian@gmail.com>
	 <7vzl3ngn7w.fsf@alter.siamese.dyndns.org>
	 <76718491002051758s577d8b5eq2323cd66d479662@mail.gmail.com>
	 <7vtytvf4vp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 05:24:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdcDY-0004wT-Tj
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 05:24:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753589Ab0BFESr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2010 23:18:47 -0500
Received: from mail-iw0-f185.google.com ([209.85.223.185]:45777 "EHLO
	mail-iw0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753412Ab0BFESq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Feb 2010 23:18:46 -0500
Received: by iwn15 with SMTP id 15so1763142iwn.19
        for <git@vger.kernel.org>; Fri, 05 Feb 2010 20:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=070jjvZdIhFg/LunQXtD97O4K0xy5glyGENSlLnNRaU=;
        b=IOeAy0UDuO8Tz7vktIkQRfERdTztReZFPNNJrgGAbCDXNtSYuRdtV2FchKmQBq9C9s
         8X8404cboNI7xdLkq+CvxXqjC+r6glDPT3nl5OfRczEPO4W7JCL94p2cAl69OsiryNvL
         /KSIs2UwjCEVXdoZZc1HVfLT6icHivXqSnjMM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CSEHHJwjOxE2HU0XH0VkP5UGa28ngM89r8M0OGEy+6xMAn4ErMpbMIEyYeoVbvS/X5
         dJSj9+5pPiszCSPxaPmWwOG14nqAocApaiFRobfscgK6F8gT3ZHnB14sF+Z/mHJZjCb0
         +R3m7a1kgC3Faxln6X5yNH9f8g9lPF1K39pmI=
Received: by 10.231.168.133 with SMTP id u5mr3952562iby.29.1265429925546; Fri, 
	05 Feb 2010 20:18:45 -0800 (PST)
In-Reply-To: <7vtytvf4vp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139141>

On Fri, Feb 5, 2010 at 9:57 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
>> Hmfph. So I know some folks don't like polluting log messages (e.g.,
>> the git-svn-id footer, or apparently, the cherry-pick -x message),..=
=2E
>
> That reminds me of a slightly related topic. =C2=A0I've been running =
git-svn to
> follow (but never build) a project without metadata, exactly because =
I do
> not want the log message contamination. I am having a hard time mappi=
ng
> the commit object name back to the upstream subversion serial number.

Since there is a difference of opinion here, how about this proposal:

1) We keep -x in cherry-pick

2) I convince you to add my -x patch to rebase.sh (hmm, how to do that?=
) :-)

3) We add a -X option to both cherry-pick and rebase.sh that records
in the notes instead of in the log message.

> I ended up using this hacky script for that. =C2=A0It finds the svn u=
uid from
> the metadata file, and then finds ".rev_map.$uuid" files from all ove=
r the
> place to see if any of them contains a record that points at the git
> commit I am interested in.
>
> I really wish "git svn" has a built-in way to do something like that;
> perhaps I didn't look hard enough.

Is git svn find-rev not what you want? (Caveat, it doesn't seem to
work for me, but it's claimed description seems to be what you're
asking for.)

j.
