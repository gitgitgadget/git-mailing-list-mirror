From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] config: Use parseopt.
Date: Sun, 15 Feb 2009 14:51:45 +0200
Message-ID: <94a0d4530902150451w2467bee2q225643f15ffffac1@mail.gmail.com>
References: <alpine.DEB.1.00.0902141230250.10279@pacific.mpi-cbg.de>
	 <1234612989-32297-1-git-send-email-felipe.contreras@gmail.com>
	 <alpine.DEB.1.00.0902142041370.10279@pacific.mpi-cbg.de>
	 <94a0d4530902141231t143067e5n872558a4e515be4a@mail.gmail.com>
	 <alpine.DEB.1.00.0902142328530.10279@pacific.mpi-cbg.de>
	 <94a0d4530902150104n555b845bofc5897230c64a5f2@mail.gmail.com>
	 <alpine.DEB.1.00.0902151224450.10279@pacific.mpi-cbg.de>
	 <94a0d4530902150407u1bc6669cr2584ff8f1a8b47af@mail.gmail.com>
	 <alpine.DEB.1.00.0902151329370.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=000e0cd28d144c95810462f488f0
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 15 13:57:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYgYm-0006m5-3x
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 13:57:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753461AbZBOMvs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 07:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753191AbZBOMvs
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 07:51:48 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:37107 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752540AbZBOMvr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 07:51:47 -0500
Received: by fg-out-1718.google.com with SMTP id 16so118547fgg.17
        for <git@vger.kernel.org>; Sun, 15 Feb 2009 04:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=WTRxd7geyd+ZW/jL2Em1PtOVqgW4lh5Lhuv/S+9IRAc=;
        b=rM2xApbcJXcwmbEECoICHH4fnoh7zmIXiOiuD1lcdDZYMdMujIPaPPNzyKs9vRMQyU
         +6GLArZBjUO+DGrq7W0ETK1ZbPJWBsIOrkl0bjhA1HxtK/i5SUcAi/g4MIiF/ljlq6Lw
         tioF5V+1PeFdkAuK6auuNBJfo00mS1LPPEN90=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=iqgV3WWWWODnx9LKGYZEX0bN03FXILBiWjfjP2264muiqjP3rrsc3UyACp0D2j1wW0
         WFWMFpFo64vf4FtIpsP7NWIDJQmMKuXgv6+iyXnuWkDhhSAA8XqC+nFlbooGBKmqLi3m
         ei978G3TtlXdCGIJdfG7lREvBG/121Fv46szc=
Received: by 10.86.92.9 with SMTP id p9mr837502fgb.15.1234702305104; Sun, 15 
	Feb 2009 04:51:45 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902151329370.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110005>

--000e0cd28d144c95810462f488f0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Sun, Feb 15, 2009 at 2:33 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sun, 15 Feb 2009, Felipe Contreras wrote:
>
>> On Sun, Feb 15, 2009 at 1:26 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>> > Hi,
>> >
>> > On Sun, 15 Feb 2009, Felipe Contreras wrote:
>> >
>> >> On Sun, Feb 15, 2009 at 12:32 AM, Johannes Schindelin
>> >> <Johannes.Schindelin@gmx.de> wrote:
>> >> > Hi,
>> >> >
>> >> > On Sat, 14 Feb 2009, Felipe Contreras wrote:
>> >> >
>> >> >> On Sat, Feb 14, 2009 at 9:59 PM, Johannes Schindelin
>> >> >> <Johannes.Schindelin@gmx.de> wrote:
>> >> >>
>> >> >> > On Sat, 14 Feb 2009, Felipe Contreras wrote:
>> >> >> >
>> >> >> >> +     else if (actions & ACTION_EDIT) {
>> >> >> >> +             const char *config_filename;
>> >> >> >> +             if (config_exclusive_filename)
>> >> >> >> +                     config_filename = config_exclusive_filename;
>> >> >> >> +             else
>> >> >> >> +                     config_filename = git_path("config");
>> >> >> >
>> >> >> > Why not reuse config_exclusive_filename here?
>> >> >>
>> >> >> You mean:
>> >> >> if (!config_exclusive_filename)
>> >> >>   config_exclusive_filename = git_path("config");
>> >> >
>> >> > Yes.
>> >>
>> >> I'm not sure about this one. At least git_config should be moved before
>> >> that code, otherwise it will only try to read core.editor from the
>> >> exclusive_filename and that's not what we want.
>> >
>> > Ah!  I did not think about core.editor, of course, but that is what got
>> > you started with git-config, after all.
>> >
>> > However, the next line sets config_exclusive_filename, does it not?
>>
>> Huh? Which line?
>
> Ah, I misremembered.  Your current patch shows this:
>
> +       else if (actions & ACTION_EDIT) {
> +               const char *config_filename;
> +               if (config_exclusive_filename)
> +                       config_filename = config_exclusive_filename;
> +               else
> +                       config_filename = git_path("config");
> +               git_config(git_default_config, NULL);
> +               launch_editor(config_filename, NULL, NULL);
> +       }
>
> ... which makes me believe that the point about moving git_config() before
> setting config_exclusive_filename is rather weak :-)
>
> +       else if (actions & ACTION_EDIT) {
> +               git_config(git_default_config, NULL);
> +               launch_editor(config_exclusive_filename ?
> +                       config_exclusive_filename : git_path("config"),
> +                       NULL, NULL);
> +       }
>
> (This has whitespace issues, as I copy-pasted it using kterm's clipboard
> functions.)

I thought on that before but now it makes more sense to me. Attaching the patch.

-- 
Felipe Contreras

--000e0cd28d144c95810462f488f0
Content-Type: application/octet-stream; 
	name="0001-config-Cleanup-editor-action.patch"
Content-Disposition: attachment; 
	filename="0001-config-Cleanup-editor-action.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fr7pu1y90

RnJvbSA0YjNkYjNkMTMyNjE4NDljZDdkNTYxZGMyMGJkZGIzNzVmMTQzMGM4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBGZWxpcGUgQ29udHJlcmFzIDxmZWxpcGUuY29udHJlcmFzQGdt
YWlsLmNvbT4KRGF0ZTogU3VuLCAxNSBGZWIgMjAwOSAxNDo0Njo1OCArMDIwMApTdWJqZWN0OiBb
UEFUQ0hdIGNvbmZpZzogQ2xlYW51cCBlZGl0b3IgYWN0aW9uLgoKQ29weS1wYXN0ZSBmcm9tIEpv
aGFubmVzIFNjaGluZGVsaW4uCgpTaWduZWQtb2ZmLWJ5OiBGZWxpcGUgQ29udHJlcmFzIDxmZWxp
cGUuY29udHJlcmFzQGdtYWlsLmNvbT4KLS0tCiBidWlsdGluLWNvbmZpZy5jIHwgICAgOSArKyst
LS0tLS0KIDEgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2J1aWx0aW4tY29uZmlnLmMgYi9idWlsdGluLWNvbmZpZy5jCmluZGV4IDJj
MWFkNzEuLmJkN2JhYzQgMTAwNjQ0Ci0tLSBhL2J1aWx0aW4tY29uZmlnLmMKKysrIGIvYnVpbHRp
bi1jb25maWcuYwpAQCAtMzcwLDEzICszNzAsMTAgQEAgaW50IGNtZF9jb25maWcoaW50IGFyZ2Ms
IGNvbnN0IGNoYXIgKiphcmd2LCBjb25zdCBjaGFyICp1bnVzZWRfcHJlZml4KQogCX0KIAllbHNl
IGlmIChhY3Rpb25zICYgQUNUSU9OX0VESVQpIHsKIAkJY2hlY2tfYXJnYyhhcmdjLCAwLCAwKTsK
LQkJY29uc3QgY2hhciAqY29uZmlnX2ZpbGVuYW1lOwotCQlpZiAoY29uZmlnX2V4Y2x1c2l2ZV9m
aWxlbmFtZSkKLQkJCWNvbmZpZ19maWxlbmFtZSA9IGNvbmZpZ19leGNsdXNpdmVfZmlsZW5hbWU7
Ci0JCWVsc2UKLQkJCWNvbmZpZ19maWxlbmFtZSA9IGdpdF9wYXRoKCJjb25maWciKTsKIAkJZ2l0
X2NvbmZpZyhnaXRfZGVmYXVsdF9jb25maWcsIE5VTEwpOwotCQlsYXVuY2hfZWRpdG9yKGNvbmZp
Z19maWxlbmFtZSwgTlVMTCwgTlVMTCk7CisJCWxhdW5jaF9lZGl0b3IoY29uZmlnX2V4Y2x1c2l2
ZV9maWxlbmFtZSA/CisJCQkgICAgICBjb25maWdfZXhjbHVzaXZlX2ZpbGVuYW1lIDogZ2l0X3Bh
dGgoImNvbmZpZyIpLAorCQkJICAgICAgTlVMTCwgTlVMTCk7CiAJfQogCWVsc2UgaWYgKGFjdGlv
bnMgJiBBQ1RJT05fQUREKSB7CiAJCWNoZWNrX2FyZ2MoYXJnYywgMiwgMik7Ci0tIAoxLjYuMS4z
Cgo=
--000e0cd28d144c95810462f488f0--
