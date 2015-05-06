From: =?UTF-8?B?U8OpYmFzdGllbiBHdWltbWFyYQ==?= 
	<sebastien.guimmara@gmail.com>
Subject: Re: [PATCH 0/3] git help: group common commands by theme
Date: Wed, 06 May 2015 22:26:22 +0200
Message-ID: <554A78EE.1040002@gmail.com>
References: <cover.1430770308.git.sebastien.guimmara@gmail.com> <CAPig+cT9X-nXhQyjDtzLzm-A2LWLaCDThR9_xh=G049SqKHccw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed May 06 22:26:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yq5tm-0005xN-Hd
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 22:26:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618AbbEFU00 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 May 2015 16:26:26 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:35155 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197AbbEFU0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 16:26:25 -0400
Received: by widdi4 with SMTP id di4so216489398wid.0
        for <git@vger.kernel.org>; Wed, 06 May 2015 13:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=fWpI8gBouqFK/L13vxVVWuNdFhvb5RfkUwKxwFWGpiI=;
        b=E2UPI5RKoM8vF3Fy44k0XoDE9pcPve3GivBthQVIWHpgFxGkSjn5kIofPmXVH9jze+
         I7z6PYtnQfRxaKnzlev9dBzS6GFnrX5sdJ9aAAxtsu6XX+oD6cbl5FtVzhUu2AgLRyZS
         9BKuLhmqAzee5q/sAX+bT5xyQj+rKHFljuYVMY/zgr243GKN8Tq7JP39Q/hU/4BN6IHl
         UOmI+aCIu7UHv+H2cQtJ2JtAJv1HxIZjH2VbxJkp+6tI8MUreMgfgIXViT2AgUO/dIto
         6fPUsX1KQ5gu2UEsW8Uc1HfckeMvmIgDwfS7iTi0Gi2R+bUtvDSdYsC+hjANHSccyVf5
         lDcQ==
X-Received: by 10.180.105.227 with SMTP id gp3mr454465wib.56.1430943984289;
        Wed, 06 May 2015 13:26:24 -0700 (PDT)
Received: from [192.168.0.15] (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id z12sm4356018wjw.39.2015.05.06.13.26.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 May 2015 13:26:23 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <CAPig+cT9X-nXhQyjDtzLzm-A2LWLaCDThR9_xh=G049SqKHccw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268494>

On 05/06/2015 05:08 AM, Eric Sunshine wrote:
> On Mon, May 4, 2015 at 4:28 PM, S=C3=A9bastien Guimmara
> <sebastien.guimmara@gmail.com> wrote:
>> This v4 includes the following suggestions:
>>
>> In command-list.txt:
>> - Add a [groups] block containing names and description for groups:
>>
>>     [groups]
>>     init                   starting a working area
>>     worktree               working on the current change
>>     remote                 working with others
>>     info                   examining the history and state
>>     history                growing, marking and tweaking your histor=
y
>>
>> - Add a [commands] header on top of the known command list, and
>>    group names as a third column.
>>
>>     [commands]
>>     git-add            mainporcelain                common-worktree
>>     git-am             mainporcelain
>>     git-annotate       ancillaryinterrogators
>>     git-apply          plumbingmanipulators
>>     git-archimport     foreignscminterface
>>     git-archive        mainporcelain
>>     git-bisect         mainporcelain
>>     git-blame          ancillaryinterrogators
>>     git-branch         mainporcelain                common-history
>
> Thanks, this version is looking better. I, personally, still find the
> redundant "command-" prefix ugly and would just as soon see it go
> away. I'll make some suggestions about that when reviewing patch 2/3.

Indeed, I'm a bit annoyed by this prefix. We could do two things:
- either drop the [deprecated] options, since it's never used.
- or keep it, but make it exclusive with [common]. It makes sense after
   all that if a command is deprecated, we don't want to consider it
   common anymore.

In both cases, we end up with only three columns, the third being
optional.

The common- prefix can then be removed in favor of the group ID alone.

>> I removed from the list of common commands: rebase, rm, mv, bisect
>> because [1] they are not really common to an unfamiliar user, [2] to
>> save vertical space occupied by group headers.
>
> Please perform the removals in a separate (preparatory) patch. Not
> only is it difficult to spot the removals mixed in with the primary
> changes of 1/3, but they are not even mentioned in the commit message
> of that patch. More generally, the removals are a logically distinct
> change from assigning groupings to the common commands, thus deserve
> their own patch.
>

Thanks. I will separate both patches.
