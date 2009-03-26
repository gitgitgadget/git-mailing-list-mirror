From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] fast-export: Avoid dropping files from commits
Date: Wed, 25 Mar 2009 18:06:46 -0600
Message-ID: <51419b2c0903251706n7cfa053eheff542d20ca9a753@mail.gmail.com>
References: <1238014519-11683-1-git-send-email-newren@gmail.com>
	 <alpine.DEB.1.00.0903252312460.26370@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 26 01:08:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmd8v-0006j9-Up
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 01:08:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752990AbZCZAGu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Mar 2009 20:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752861AbZCZAGu
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 20:06:50 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:10464 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbZCZAGt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Mar 2009 20:06:49 -0400
Received: by an-out-0708.google.com with SMTP id d14so251937and.1
        for <git@vger.kernel.org>; Wed, 25 Mar 2009 17:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MjwwKczcBMsS2ZDZ9/+5k+Y9arVWs94OkAgoC4dsMOA=;
        b=AX3ZLjJYIgW+fvLtIwZDFzhWeUHT9KPLFn3TebUYbKNKYArQyfzM2LUlguNgg2GxAP
         Woy/mlTvSIBfiQqLo/KYOHjXsSRsG0uMy55JgHIOKkpGzUYa3R9pC+jbVddQYpi8QzvI
         XLQcfXPj3p+tMAkg703jhbyBhD/lLS3//tdPs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oGwogVSP6cSW4uwcI43O5tKT6IXxhbj+5u6pMXKg9dESp3nvJZP2wOg5PDD7+q/Z2U
         fmeec/RuafWHRwg7h5kt0GvCQt4n8VaeIR/dAzQ2LU1FA/Nf69aNpBjUD1SF+FINq7w5
         DFzn/tuffapD919l334BG94x4+XyandABZ3eY=
Received: by 10.231.19.70 with SMTP id z6mr47787iba.29.1238026007091; Wed, 25 
	Mar 2009 17:06:47 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0903252312460.26370@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114694>

Hi,

On Wed, Mar 25, 2009 at 4:13 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>> - =C2=A0 =C2=A0 if (commit->parents) {
>> + =C2=A0 =C2=A0 if (commit->parents &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 get_object_mark(&commit->parents->item=
->object) !=3D 0) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parse_commit(commit=
->parents->item);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diff_tree_sha1(comm=
it->parents->item->tree->object.sha1,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0commit->tree->object.sha1, "", &rev-=
>diffopt);
>
> I do not understand that change.
>
> A good explanation in the commit message might help this stupid devel=
oper.

I resent the patch in another email (sorry for the duplication, but I
don't trust gmail to preserve patches, and responding inline to
comments via git-send-email isn't so great either).  Let me know if
the explanation is missing anything, is too detailed, or is using
incorrect terminology.  In two cases I was sufficiently unsure about
my wording that I provided extra wording to try to make it clear what
I was talking about.

Thanks,
Elijah
