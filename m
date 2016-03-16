From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC/GSoC 05/17] rebase-options: implement rebase_options_load()
 and rebase_options_save()
Date: Wed, 16 Mar 2016 09:04:21 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603160901520.4690@virtualbox>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com> <1457779597-6918-6-git-send-email-pyokagan@gmail.com> <CAGZ79kYeYzi=J=dY27FqXp72BRe-Vmm4MR5Q6dFTMUP9CxYZcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Paul Tan <pyokagan@gmail.com>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Sam Halliday <sam.halliday@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 09:04:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ag6Rb-0007rv-Or
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 09:04:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933774AbcCPIEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 04:04:35 -0400
Received: from mout.gmx.net ([212.227.15.19]:63864 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933246AbcCPIEa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 04:04:30 -0400
Received: from virtualbox ([37.24.143.87]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Md3Eg-1aP7YK2qxu-00IEZd; Wed, 16 Mar 2016 09:04:22
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CAGZ79kYeYzi=J=dY27FqXp72BRe-Vmm4MR5Q6dFTMUP9CxYZcg@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:LpxSfERLQhtT7bDlmPC57KAwJAgJ13b0PVBhXBMaM2u+PKiLEYv
 EUt7C+5Ni7Vte79SOqwQtDsF6xjTmpc0s40NnF5QicF9hhd05pZozPAtoeiv8JVZou2xN7v
 iX5d7iOstlHoPyu8Z7QEpcoH6mbJuYbXUmMm3A8NSa1WFBhT4atUs7CdecYnLyzOfR0vdAW
 yWSxQQwuljvXh72S+UigA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:q0dSspW0GBs=:Un8pwVck9sFk8u0rdcHW5h
 PbeblwjUwLJvcKQ3o6rTOvrcLhaxyGyTSeu0qMsf59Qs/ZylEMGTBAwEN3hIwj/AMs7BLhir6
 xUGuq3V6ykZxbt05IW5qSQnkR5ct6SP/kzDCNmFuhV7eh3Lcq0eMJ2QMxmxl61pP+WXNI7tDl
 lba1ifE2oJ3lmYshJeC/FmiIBIadYQEkCGduWTBRYYetyU+8bchRHbXPOPIqliCNJl/2uQ+J8
 NVYMXD6OEjtXJxJBL35xHl3Mr/m7+RUZL0eubAkrwwkbCkglYClb2i6RHEizqb+wvVaJnv2pT
 cq0ZnItiTv3RYGUP2OM+IWPq/FhD0ZsVqHCju6a9suExPowbcC3NHoaY4U6OLDjfaJ9D09dAr
 yy08HF0b80OwFTzJRmyGRMh7GowIo9eGeF4XEAahG0LUcX5tmIlUbSDJfWku0OiVrexhDb5gz
 Q7Pk78dLTWyb5GkoGZHoa0flz3RbTUWkMFsAzvJXLfwDj/vGChsGZmFSlsSW2uFQ5wb6IIVHk
 GVUBzWnFRHa8yy3+s/p3d9oQfYyPwwGCEwyhZDHtu8W/kYOJB2Cm+BrPhbteixVlzP8xOGEek
 Jxwakv7bv+cxrSh2R3NIlioYVNsdNQBJnOoyJHBDXgtOjkQcnxJH7tfSGVzEHTBMj+aRouLHn
 nH/Iz3FBKMwXf11g1LT95O0dg4v8yohHrMXMGx7VBhM+g0Bc0vmLxUzzLqnUaT8HLMMzrHC/0
 tejZ9a8KiMTMrUeCZr4+4xNGZZV+JKApdDJDTTD1tUmPFyi3o0YHl9j1NI+4A2ZjIzGJbkjG 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288951>

Hi Paul,

On Mon, 14 Mar 2016, Stefan Beller wrote:

> On Sat, Mar 12, 2016 at 2:46 AM, Paul Tan <pyokagan@gmail.com> wrote:
> > These functions can be used for loading and saving common rebase options
> > into a state directory.
> >
> > Signed-off-by: Paul Tan <pyokagan@gmail.com>
> > ---
> >  rebase-common.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  rebase-common.h |  4 ++++
> >  2 files changed, 73 insertions(+)
> >
> > diff --git a/rebase-common.c b/rebase-common.c
> > index 5a49ac4..1835f08 100644
> > --- a/rebase-common.c
> > +++ b/rebase-common.c
> > @@ -26,3 +26,72 @@ void rebase_options_swap(struct rebase_options *dst, struct rebase_options *src)
> >         *dst = *src;
> >         *src = tmp;
> >  }
> > +
> > +static int state_file_exists(const char *dir, const char *file)
> > +{
> > +       return file_exists(mkpath("%s/%s", dir, file));
> > +}
> 
> How is this specific to the state file? All it does is create the
> leading directory
> if it doesn't exist? (So I'd expect file_exists(concat(dir, file)) to
> have the same
> result without actually creating the directory if it doesn't exist as
> a side effect?
> 
> If the dir doesn't exist it can be created in rebase_options_load explicitly?

In addition I want to point out that sequencer's replay_opts seem to be at
least related, but the patch shares none of its code with the sequencer.
Let's avoid that.

In other words, let's try to add as little code as possible when we can
enhance existing code.

Ciao,
Dscho
