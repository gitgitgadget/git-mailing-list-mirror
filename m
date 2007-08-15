From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: git on Cygwin: Not a valid object name HEAD
Date: Wed, 15 Aug 2007 15:06:58 +0200
Message-ID: <3F9AF722-0610-4778-A244-DBE5A0918D0B@zib.de>
References: <76795DDC-29A5-4C7E-B56E-A6316A183C75@zib.de> <e7bda7770708101531n782118e9qb9c6de4e934940ea@mail.gmail.com> <EF7DFA5A-9C3A-4D0B-9533-D1D60AE4A44C@zib.de> <e7bda7770708141704m587dfdbdqfbab51b8ac6fcff@mail.gmail.com> <30FE2B1C-B651-4F1D-B5D9-CD3C3261F531@zib.de> <85fy2l1i1g.fsf@lola.goethe.zz> <ABA1D7D2-92A6-4E8C-AC36-93912621E3D4@zib.de> <86k5rx474o.fsf@lola.quinscape.zz> <20070815073811.GL27913@spearce.org> <30e4a070708150542m3f3f5c62l5e4bf5b3ff098b52@mail.gmail.com> <30e4a070708150548r3234cd66yd4ee6a85989a98b1@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"David Kastrup" <dak@gnu.org>,
	"Torgil Svensson" <torgil.svensson@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 15:06:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILIZz-0006Fc-Rz
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 15:06:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755389AbXHONGY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 09:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754531AbXHONGX
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 09:06:23 -0400
Received: from mailer.zib.de ([130.73.108.11]:59815 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751606AbXHONGW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 09:06:22 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l7FD6DRe004126;
	Wed, 15 Aug 2007 15:06:13 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l7FD6Cg5009302
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 15 Aug 2007 15:06:12 +0200 (MEST)
In-Reply-To: <30e4a070708150548r3234cd66yd4ee6a85989a98b1@mail.gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55899>


On Aug 15, 2007, at 2:48 PM, Mark Levedahl wrote:

> On 8/15/07, Mark Levedahl <mlevedahl@gmail.com> wrote:
>> On 8/15/07, Shawn O. Pearce <spearce@spearce.org> wrote:
>>> David Kastrup <dak@gnu.org> wrote:
>>>>     Load a Hive, Query, Save, Restore, and Unload a Hive. To  
>>>> install
>>>>     the Support Tools:
>>>>
>>>>     1.
>>>>
>>>>
>>>>     Insert the Windows 2000 CD-ROM into your CD-ROM drive.
>>>
>>> Indeed, that step right there will stop many users cold in their
>>> tracks.
>>
> maybe something like ...
>
> case "$(uname -s) in
>    MSYS*)
>        <your way>;;
>    *)
>        <the unix way>;;
> esac

If reg.exe is not there kdiff3 will not be found. The code will
already be _ignored_. It's just not working.

It may make sense to use 'uname -s' to explicitly control that the
code is expected to work. This would allow to report errors if a
command is missing. However, cluttering all shell scripts with
uname's will likely become quite confusing.

If performance is a concern, we may execute uname -s only once
in git-sh-setup and assign its return to something like GIT_UNAME.
This may save us a few forks, which are to my knowledge quite
expensive on Windows.

	Steffen
