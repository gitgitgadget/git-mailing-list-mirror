From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH v2 2/2] t/t3308-notes-merge.sh: succeed with relaxed notes refs
Date: Tue, 6 Jan 2015 17:51:15 -0800
Message-ID: <74EB0B94-0FD1-4AD2-9493-20DB02FC5071@gmail.com>
References: <d4509363c8f670483dacdd2a5070f5a@74d39fa044aa309eaea14b9f57fe79c> <e514c72c481c66f9808f1dd09117a16@74d39fa044aa309eaea14b9f57fe79c> <xmqq8uhgqkge.fsf@gitster.dls.corp.google.com> <F6072C48-FA50-4F9D-AD26-0B4C4DD64B91@gmail.com> <xmqqtx03pxzf.fsf@gitster.dls.corp.google.com> <A5A16FEC-D72C-4B21-8BE1-3A41696DFF49@gmail.com> <CALKQrge3yEfmi26HMbckyw_ONRXUWtZGvz=SqqYaL2sqJaHbUg@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	Scott Chacon <schacon@gmail.com>, Jeff King <peff@peff.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jan 07 02:51:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8fmN-00073H-Hj
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 02:51:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756418AbbAGBvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 20:51:19 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:40285 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756188AbbAGBvS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 20:51:18 -0500
Received: by mail-pa0-f46.google.com with SMTP id lf10so1492159pab.5
        for <git@vger.kernel.org>; Tue, 06 Jan 2015 17:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=5hGmzFGNmMT4R/6hpCTerVFtpL/a0gQLFErLfBN8iZo=;
        b=AOOwQKEHKXRV2FnMTOee9+yZqBvQ1OMnfBkmY2PH+Y5kzIsndIT47gtMbzSXzSOGnq
         px5AqiVzT2mQ5XQu8hevIAL5buCPkDveVbnXZ/GaiQZ12AsAYdhC7EVfkPvhl6o8RDCv
         AeN+zQdoBu7lVHgXiOvl5PGzDzaPmUK4t2Baiq74EhqR2bC8DWv1Grl55c5MIf8Nlw/S
         TuVHgvNlEvgubAlT7ArsZw+bdTNvLl4FZncMBsF0etgIey6ml933GiWriOIOZ2adSr4H
         YKHe1ygrgeZznJ6rNYq8m//SubObCRL8LGbQ+fuEEXQ2tCPQT3L5dgZ40On/eLEzckr/
         ExmQ==
X-Received: by 10.70.40.139 with SMTP id x11mr718403pdk.124.1420595478302;
        Tue, 06 Jan 2015 17:51:18 -0800 (PST)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id fs1sm150100pdb.16.2015.01.06.17.51.16
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 06 Jan 2015 17:51:17 -0800 (PST)
In-Reply-To: <CALKQrge3yEfmi26HMbckyw_ONRXUWtZGvz=SqqYaL2sqJaHbUg@mail.gmail.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262126>

On Jan 6, 2015, at 16:28, Johan Herland wrote:

> On Wed, Jan 7, 2015 at 12:29 AM, Kyle J. McKay <mackyle@gmail.com>  
> wrote:
>> Perhaps that is the crux of the issue.  There is no git notes- 
>> plumbing
>> command where the git notes command continues to apply restrictions  
>> but the
>> vaporware notes-plumbing command allows anything just like update- 
>> ref does.
>
> Good observation. From my POV, as people start creating tools that use
> notes in a more structured manner (than as free-form plain-text  
> appendages
> to commit messages), the sharp and pointy bits (and bugs) of the  
> interface
> come into view. This applies to the safety features being discussed  
> in this
> thread, but also IMHO to the other things being currently discussed/ 
> fixed
> in the notes code:
> [...]
> I haven't considered that we might at some point be
> better off splitting out a separate plumbing command for manipulating
> notes. However, I'm not sure we're there, yet. The problems raised so
> far do not IMHO warrant the creation of a whole new plumbing command.
> Instead, we can still keep fixing and improving 'git notes'.
>
>> 1) There's no simple way to store remote notes refs outside the  
>> refs/notes
>> namespace in such a way that they can be used with git notes  
>> commands.
>>
>> 2) People who want to experiment with using git notes storage as a  
>> basis for
>> building some new feature are forced to store their refs under the
>> refs/notes namespace even if that does not make sense for the  
>> feature when
>> what's stored in the notes tree is not intended to provide any  
>> content that
>> is directly meaningful to the user.
>
>> A whitelist solves issue (1) but is no help for issue (2) unless some
>> additional additional part of the refs namespace were to be also
>> whitelisted.  Perhaps something like refs/x-<anything>/... in the  
>> same vein
>> as the various IETF standards for experimental names.
>
> Alternatively (or additionally), for issue (2), we could add a
> --disable-ref-safety option to 'git notes', to explicitly disable the
> safety checks for "experimental" use.

I like that.  Sort of a poor-man's git notes-plumbing option.  And  
there is precedence for this sort of thing as recently (v2.2.0) git  
hash-object learned a "--literally" option to bypass checks it would  
otherwise normally perform.

-Kyle
