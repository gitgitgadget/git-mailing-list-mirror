From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC] "Remote helper for Subversion" project
Date: Sun, 4 Mar 2012 01:54:25 -0600
Message-ID: <20120304075424.GI14725@burratino>
References: <1330777646-28381-1-git-send-email-davidbarr@google.com>
 <CAFfmPPMPDCKjAmZ85Cj1cdT2yAUykm9sV6a66zXeFRmYfrmtjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Sun Mar 04 08:55:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S46HY-0005LA-9t
	for gcvg-git-2@plane.gmane.org; Sun, 04 Mar 2012 08:55:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201Ab2CDHyb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Mar 2012 02:54:31 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52540 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159Ab2CDHya convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Mar 2012 02:54:30 -0500
Received: by iagz16 with SMTP id z16so4187295iag.19
        for <git@vger.kernel.org>; Sat, 03 Mar 2012 23:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=S003+yy9psI71iuSdRHFnEuVzxmwibVbsql8G2eiwVQ=;
        b=FPkqaoLsZym/EirAs2nKEwoiQEIEQU79E5cyXGy1cgH/KYspuqWeI1N0cR1qj18vn/
         FRthkSq/Kc296k2okyzXyJkBBROjUV53AmRjMSuVRSq32tWf+nDA7sWPDvJ+UlZ7MGtp
         h5socnT4YHx9HgbXCGn1mHFlVuKk8B86OIAfyaLwCFgEkjrW+rAJV0B+PJ9o5jhPMZSK
         INzdrAajhfdjZADhLR56YahH+qx0lIfh2Di+93ZXJtWiKIvPIhwkskOKOaK3a2iWg76z
         rJTO0SvVXv/jm2B0fYopDubtoJZoTCpS8Vv2JYzHn4i1+nfXegHjSP83sL+FVTNW+Joe
         uGQQ==
Received: by 10.50.100.165 with SMTP id ez5mr1904152igb.35.1330847670310;
        Sat, 03 Mar 2012 23:54:30 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id bi6sm5193974igc.3.2012.03.03.23.54.29
        (version=SSLv3 cipher=OTHER);
        Sat, 03 Mar 2012 23:54:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAFfmPPMPDCKjAmZ85Cj1cdT2yAUykm9sV6a66zXeFRmYfrmtjg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192146>

David Barr wrote:
> On Sat, Mar 3, 2012 at 11:27 PM, David Barr <davidbarr@google.com> wr=
ote:

>> --- a/SoC-2012-Ideas.md
>> +++ b/SoC-2012-Ideas.md
>> @@ -182,3 +182,29 @@ this project.
>>
>> =C2=A0Proposed by: Thomas Rast
>> =C2=A0Possible mentor(s): Thomas Rast
>> +
>> +Remote helper for Subversion
>> +------------------------------------
>> +
>> +Write a remote helper for Subversion. While a lot of the underlying
>> +infrastructure work was completed last year, the remote helper itse=
lf
>> +is essentially incomplete. Major work includes:

By the way, didn't we have a remote-svn prototype?  I'm happy to merge
any old hacky thing for staging in contrib/svn-fe, as long as it is
not documented in a misleading way.

(More generally, if anyone wants to resend useful svn-fe patches, that
will help a lot.)

>> +
>> +* Understanding revision mapping and building a revision-commit map=
per.

Does this mean creating commit notes to record which subversion rev
corresponds to each commit, and marks or lightweight tags going the
other way?

>> +
>> +* Working through transport and fast-import related plumbing, chang=
ing
>> + =C2=A0whatever is necessary.

I think Dmitry and Sverre took care of most of this.

>> +
>> +* Getting an Git-to-SVN converter merged.

Probably could fill a summer in itself.  In previous starts I think
there was some complexity creep. :/

 http://thread.gmane.org/gmane.comp.version-control.git/170290
 http://thread.gmane.org/gmane.comp.version-control.git/170551

>> +
>> +* Building the remote helper itself.
>> +
>> +Goal: Build a full-featured bi-directional `git-remote-svn` and get=
 it
>> + =C2=A0 =C2=A0 =C2=A0merged into upstream Git.

Sure would be neat. ;-)  Another nice piece to build would be branch
tracking / follow_parent heuristics.

Thanks,
Jonathan
