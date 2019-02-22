Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D0821F453
	for <e@80x24.org>; Fri, 22 Feb 2019 03:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfBVDhh (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 22:37:37 -0500
Received: from mail-eopbgr710094.outbound.protection.outlook.com ([40.107.71.94]:6372
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725869AbfBVDhg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 22:37:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ontextron.onmicrosoft.com; s=selector1-trusimulation-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKIdvWQLi2Lv07jS26ip5atIxMtBDkc4nn1EiEJ6ViI=;
 b=P1G6nMNtch+rxrUFAjx4G3VHoTTcrHe7kTt0Ig8brpqXkdqS4XQ/9OJhtbniawHM0fkV8NHP1Ktb02PGUHk4EDyq6x2S2dQnoG81zHzUHoZ4Pblqjw9agwHx1pO0nAXfnT1RQP5XIvDXSN/u6lK8qE7HqXOW+JjSHEF+FxmxJfs=
Received: from SN6PR03MB3647.namprd03.prod.outlook.com (52.135.80.148) by
 SN6PR03MB3584.namprd03.prod.outlook.com (52.135.80.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Fri, 22 Feb 2019 03:36:45 +0000
Received: from SN6PR03MB3647.namprd03.prod.outlook.com
 ([fe80::861:67e2:77a8:bc26]) by SN6PR03MB3647.namprd03.prod.outlook.com
 ([fe80::861:67e2:77a8:bc26%6]) with mapi id 15.20.1643.018; Fri, 22 Feb 2019
 03:36:45 +0000
From:   "Garcia, Pierre" <pgarcia@trusimulation.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Bug: git for Windows spawning a lot of processes recursively
Thread-Topic: Bug: git for Windows spawning a lot of processes recursively
Thread-Index: AdTKX37R6NVOZpIeSUOzs9W/WhkzYA==
Date:   Fri, 22 Feb 2019 03:36:45 +0000
Message-ID: <SN6PR03MB3647F1CDFD95F29C86F54FF8BA7F0@SN6PR03MB3647.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pgarcia@trusimulation.com; 
x-originating-ip: [32.66.194.148]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f5857e2-209f-42f7-45ca-08d69876f81b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:SN6PR03MB3584;
x-ms-traffictypediagnostic: SN6PR03MB3584:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;SN6PR03MB3584;23:7KtG9K/uL3W+3p0O4pzmz19rOC9k4T082+IVWRj79?=
 =?us-ascii?Q?Bcjzkgv0z7AU3d1+l4DrwCsaczZbYAzOcdGMJWW7nY+jTJ7MGcoZb8LozsSf?=
 =?us-ascii?Q?cZxJbFZrssoCTRl4AR6rVxbLvAY8UKfTA9qiwDvC3YAqtA/bqymLGeoFNnOT?=
 =?us-ascii?Q?6+AjSWGsBXRecxzWrHiLiWbzDyPwxOj7ZJugn5uumFtnyVcDUHF+Vo9gws+x?=
 =?us-ascii?Q?NDQoyEOQfHxvEU2kQVJTVLC/oenZ0HfGkEz8k+/HYep0r4LkSFYce9tHaB/p?=
 =?us-ascii?Q?DgQYKopRnoPbsRGCbWLy50PdPG02l4xdfL6z4f2ojREm9IPUGbmVwrhVTi1X?=
 =?us-ascii?Q?SEuS0RT33ynObKC4542I9ZX/HV+q81/GzWek9i+Ly7OHZ5xhcxbJjuiYJle1?=
 =?us-ascii?Q?7jYw4kVc2+ymfNw/yA/+inwHNo/P++wKyXWNrJlX/n1AHtu4GDHq6lcvKp2f?=
 =?us-ascii?Q?Ihfog8ur/q7EA9jRdiGGLoQ/WHAUxNXfyGqQ45c9vPX+4f2dINu7Kn4HfshI?=
 =?us-ascii?Q?UEaefi+OT0MXyKgBheJK6oZtfKm3PMfoBasqvekFKtFC79W7fFB9pS52g9Ch?=
 =?us-ascii?Q?98rBk5nfJ0CvYB6ROHBi88wMMJYWfZMbqnr16wOUZlgiYLGLSqliAXo4ZVVV?=
 =?us-ascii?Q?Pd/8WJVC9xHs6Kr1h5mOG8EpMFWxGeoFRCXQL2Z22VDt5cC1uidk0jcs/17o?=
 =?us-ascii?Q?NBr3R9hHjVY+osZSP1Vzn4piUON1udq7YNHKzk5yc01AUuf93dO6VN0YqQ0r?=
 =?us-ascii?Q?RnEx640UEKHXEcxrJ9zE4FBqwm0qOlEYJjgCk6WsCh8PeVlKk1UsAwCKGMoy?=
 =?us-ascii?Q?n1zw8/i0xIOUBAqgwwVG8WyfaPdqFspul+F0dcwcbndWkh7q6sbybxyDpcVT?=
 =?us-ascii?Q?768dueEmmax/WB4ULp6kodXgeomCVrMTAM6tIYNFiEZhqeyF6145Yd2ZwHCM?=
 =?us-ascii?Q?EVZSyKRTlN/nwxohAFsBk64Ln7oGolh4rR+ze5MTWvrFx8dnu/Wthj67Har+?=
 =?us-ascii?Q?YfLYBUr2jABWoh2NI/RypK0dVzYdWZbPBpewmbWepV+H4Fm7Mh04GMkw2rAk?=
 =?us-ascii?Q?bvP7n9jhwXP8XWzidST5Qh+dBl/6Rg+dPakSpzyuGznJ8F3c+/2d31aYfKVn?=
 =?us-ascii?Q?SG6p4OHkwMeLY2xLzJ/qj5ZY7+JRxhLKTU5KIhZxXMOzg6zs00XZvCw++oTz?=
 =?us-ascii?Q?WE/eX+8kHyYmEnNcvdwUCYPTqrnQe5bwj+bX4MLXLjzYrsPSX+7cOjolJHQe?=
 =?us-ascii?Q?5xzC7P+vSm8iwwXSR/yqTFSAPBHHUSnN09qSAuF?=
x-microsoft-antispam-prvs: <SN6PR03MB35847230298985D74E013915BA7F0@SN6PR03MB3584.namprd03.prod.outlook.com>
x-forefront-prvs: 09565527D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(346002)(39860400002)(136003)(189003)(199004)(5660300002)(3846002)(6116002)(55016002)(8936002)(86362001)(316002)(53946003)(6506007)(26005)(74316002)(9686003)(66066001)(97736004)(1730700003)(2501003)(68736007)(71200400001)(5640700003)(71190400001)(7736002)(2351001)(305945005)(186003)(14454004)(33656002)(53936002)(6916009)(25786009)(99286004)(30864003)(14444005)(6436002)(486006)(105586002)(102836004)(478600001)(106356001)(8676002)(81156014)(7696005)(256004)(81166006)(2906002)(476003)(45080400002)(579004)(460985005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR03MB3584;H:SN6PR03MB3647.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: trusimulation.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2xJl/nxCK5GfofeA5JWRFvSiUjQA4lPjpPH7o9GOjAbS3bkuS3I0O7kWs8pwYK0t0VTuqaB8ZqsjRIN8vgzNRhVIbtxBh+wHopTxpj6tciMnI0z8E0Otkt67kqzC6gGMs3q10+XzMHM1HIfG1NXgFiX4Cj25jxGIaeLCIRquZPU/UK9JEn8rQ6x2KjzchXu97mH/umDHaPc2zMjIt5pTuQp5k4Fn8bOiZQgFp8pGy55PxlCj3rhZtGw4wHzNXq5trh4FWx9iD1oTT8uM1vNDxvjIsA9UO6HFK5JlGeo7vGd1EQAa0Yyyrx442vAqtwTYFHkECgW5qjwS4tbcPGYJSXvBLxMuEUwonVBt3mz9OkoImTYCRZZNiJ+JgXHanJJMxxwh+NYn9uoqb7jAmpwT98BPKp0Qmn/SeA88mHNjpV4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: trusimulation.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f5857e2-209f-42f7-45ca-08d69876f81b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2019 03:36:45.4422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2d5b202c-8c07-4168-a551-66f570d429b3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3584
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I'd like to report an issue with git for Windows

Git version 2.20.1
Windows 7 x64 (Build 7601: Service Pack 1)

---------------------------------------------------------------------------=
-
Issue:
When running from Git-bash (not even inside a repo), git commands from buil=
t-in are OK, but if I use the exe that is located at C:\Program Files\Git\b=
in\git.exe, the process takes long to execute and then exits with error "er=
ror launching git: The filename or extension is too long.":

$ git --version
git version 2.20.1.windows.1

$ which git
/mingw64/bin/git

$ /c/Program\ Files/Git/bin/git.exe --version
error launching git: The filename or extension is too long.

---------------------------------------------------------------------------=
-
It started out of the blue, nothing special was done on the computer, the p=
revious day I cloned some repos, the next it was not working anymore.
I tried uninstall-reinstall with no success.
I'm using Gitextensions as well, but I verified that the problem was occurr=
ing without Gitextensions (uninstalled at the time the traces were taken).

---------------------------------------------------------------------------=
-
I ran procmon.exe to monitor the activity of the process and I found out th=
at git.exe was spawning itself 385 times in total in the trace I took, unti=
l all processes exit with error code 1, here is an extract of the procmon t=
race, showing thread and process activity for git.exe (I have more exhausti=
ve trace but the file is quite big), I included the environment variables o=
n the first call:

Time of Day	Process Name	PID	Operation	Path	Result	Detail
8:57:20.7	git.exe	12744	Process Start		SUCCESS	"Parent PID: 8412, Command l=
ine: ""C:\Program Files\Git\bin\git.exe""  --version, Current directory: C:=
\Users\gpierre\Desktop\, Environment:=20
;	=3D::=3D::\
;	=3DC:=3DC:\Users\gpierre\Desktop
;	=3DExitCode=3D00000001
;	ALLUSERSPROFILE=3DC:\ProgramData
;	CommonProgramFiles=3DC:\Program Files\Common Files
;	CommonProgramFiles(x86)=3DC:\Program Files (x86)\Common Files
;	CommonProgramW6432=3DC:\Program Files\Common Files
;	ComSpec=3DC:\windows\system32\cmd.exe
;	DEFLOGDIR=3DC:\ProgramData\McAfee\Endpoint Security\Logs
;	FP_NO_HOST_CHECK=3DNO
;	GTK_BASEPATH=3DC:\Program Files (x86)\GtkSharp\2.12\
;	HasSCCM2012Client=3D1
;	HOME=3DC:\Users\gpierre
;	HOMEDRIVE=3DC:
;	HOMEPATH=3D\Users\gpierre
;	HOMESHARE=3DC:\Users\gpierre
;	LOCALAPPDATA=3DC:\Users\gpierre\AppData\Local
;	NUMBER_OF_PROCESSORS=3D4
;	OS=3DWindows_NT
;	Path=3DC:\ProgramData\Oracle\Java\javapath;C:\windows\system32;C:\windows=
;C:\windows\System32\Wbem;C:\windows\System32\WindowsPowerShell\v1.0\;C:\Pr=
ogram Files\Dell\Dell Data Protection\Encryption\;C:\Program Files (x86)\NV=
IDIA Corporation\PhysX\Common;C:\Program Files\Microsoft SQL Server\130\Too=
ls\Binn\;C:\Program Files\dotnet\;C:\Program Files (x86)\GtkSharp\2.12\bin;=
C:\windows\system32\config\systemprofile\.dnx\bin;C:\Program Files\Microsof=
t DNX\Dnvm\;C:\EASE\APEX12-4.4.0\bin;C:\EASE\APEX12-4.4.0\platforms\default=
\DEOS;C:\Program Files\PuTTY\;C:\windows\System32\WindowsPowerShell\v1.0\;C=
:\windows\System32\WindowsPowerShell\v1.0\;C:\Program Files\1E\NomadBranch\=
;C:\HashiCorp\Vagrant\bin;C:\windows\System32\WindowsPowerShell\v1.0\
;	PATHEXT=3D.COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC
;	PROCESSOR_ARCHITECTURE=3DAMD64
;	PROCESSOR_IDENTIFIER=3DIntel64 Family 6 Model 94 Stepping 3, GenuineIntel
;	PROCESSOR_LEVEL=3D6
;	PROCESSOR_REVISION=3D5e03
;	ProgramData=3DC:\ProgramData
;	ProgramFiles=3DC:\Program Files
;	ProgramFiles(x86)=3DC:\Program Files (x86)
;	ProgramW6432=3DC:\Program Files
;	PROMPT=3D$P$G
;	PSModulePath=3DC:\Program Files\WindowsPowerShell\Modules;C:\windows\syst=
em32\WindowsPowerShell\v1.0\Modules
;	PUBLIC=3DC:\Users\Public
;	SESSIONNAME=3DConsole
;	SNC_LIB=3Dgsskrb5.dll
;	SOEDataPartition=3DC:
;	SOEDesktopAdminModel=3DUser
;	SOESystemPartitionLabel=3DSOE-Disk
;	SystemDrive=3DC:
;	SystemRoot=3DC:\windows
;	TEMP=3DC:\Users\gpierre\AppData\Local\Temp
;	TMP=3DC:\Users\gpierre\AppData\Local\Temp
;	USERNAME=3Dgpierre
;	USERPROFILE=3DC:\Users\gpierre
;	VBOX_MSI_INSTALL_PATH=3DC:\Program Files\Oracle\VirtualBox\
;	VS140COMNTOOLS=3DC:\Program Files (x86)\Microsoft Visual Studio 14.0\Comm=
on7\Tools\
;	VS80COMNTOOLS=3DC:\Program Files (x86)\Microsoft Visual Studio 8\Common7\=
Tools\
;	windir=3DC:\windows
;	windows_tracing_flags=3D3
;	windows_tracing_logfile=3DC:\BVTBin\Tests\installpackage\csilogfile.log"
8:57:20.7	git.exe	12744	Thread Create		SUCCESS	Thread ID: 12748
8:57:20.7	git.exe	12744	Load Image	C:\Program Files\Git\bin\git.exe	SUCCESS=
	Image Base: 0x13a0000, Image Size: 0x52000
8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\ntdll.dll	SUCCESS	Im=
age Base: 0x77b70000, Image Size: 0x19f000
8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\kernel32.dll	SUCCESS=
	Image Base: 0x77950000, Image Size: 0x11f000
8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\KernelBase.dll	SUCCE=
SS	Image Base: 0x7fefd860000, Image Size: 0x6a000
8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\msvcrt.dll	SUCCESS	I=
mage Base: 0x7fefef60000, Image Size: 0x9f000
8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\shell32.dll	SUCCESS	=
Image Base: 0x7fefdc20000, Image Size: 0xd8a000
8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\shlwapi.dll	SUCCESS	=
Image Base: 0x7feffde0000, Image Size: 0x71000
8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\gdi32.dll	SUCCESS	Im=
age Base: 0x7fefdae0000, Image Size: 0x67000
8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\user32.dll	SUCCESS	I=
mage Base: 0x77a70000, Image Size: 0xfa000
8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\lpk.dll	SUCCESS	Imag=
e Base: 0x7fefed30000, Image Size: 0xe000
8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\usp10.dll	SUCCESS	Im=
age Base: 0x7fefdb50000, Image Size: 0xcb000
8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\imm32.dll	SUCCESS	Im=
age Base: 0x7fefe9b0000, Image Size: 0x2e000
8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\msctf.dll	SUCCESS	Im=
age Base: 0x7fefed40000, Image Size: 0x109000
8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\nvinitx.dll	SUCCESS	=
Image Base: 0x7fefd5f0000, Image Size: 0x31000
8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\version.dll	SUCCESS	=
Image Base: 0x7fefd5e0000, Image Size: 0xc000
8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\advapi32.dll	SUCCESS=
	Image Base: 0x7fefec50000, Image Size: 0xdb000
8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\sechost.dll	SUCCESS	=
Image Base: 0x7fefee50000, Image Size: 0x1f000
8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\rpcrt4.dll	SUCCESS	I=
mage Base: 0x7feff6b0000, Image Size: 0x12d000
8:57:20.8	git.exe	12744	Process Create	C:\Program Files\Git\bin\git.exe	SUC=
CESS	PID: 12756, Command line: git.exe  --version
8:57:20.8	git.exe	12756	Process Start		SUCCESS	"Parent PID: 12744, Command =
line: git.exe  --version, Current directory: C:\Users\gpierre\Desktop\, Env=
ironment:=20
8:57:20.8	git.exe	12756	Thread Create		SUCCESS	Thread ID: 12760

This repeats 385 times (I removed the Load Image lines):

8:57:20.9	git.exe	12756	Process Create	C:\Program Files\Git\bin\git.exe	SUC=
CESS	PID: 12764, Command line: git.exe  --version
8:57:20.9	git.exe	12764	Process Start		SUCCESS	"Parent PID: 12756, Command =
line: git.exe  --version, Current directory: C:\Users\gpierre\Desktop\, Env=
ironment:=20
8:57:20.9	git.exe	12764	Thread Create		SUCCESS	Thread ID: 12768
8:57:20.9	git.exe	12764	Process Create	C:\Program Files\Git\bin\git.exe	SUC=
CESS	PID: 12772, Command line: git.exe  --version
8:57:20.9	git.exe	12772	Process Start		SUCCESS	"Parent PID: 12764, Command =
line: git.exe  --version, Current directory: C:\Users\gpierre\Desktop\, Env=
ironment:=20
8:57:20.9	git.exe	12772	Thread Create		SUCCESS	Thread ID: 12776
8:57:21.0	git.exe	12772	Process Create	C:\Program Files\Git\bin\git.exe	SUC=
CESS	PID: 12780, Command line: git.exe  --version
8:57:21.0	git.exe	12780	Process Start		SUCCESS	"Parent PID: 12772, Command =
line: git.exe  --version, Current directory: C:\Users\gpierre\Desktop\, Env=
ironment:=20
8:57:21.0	git.exe	12780	Thread Create		SUCCESS	Thread ID: 12784
8:57:21.0	git.exe	12780	Process Create	C:\Program Files\Git\bin\git.exe	SUC=
CESS	PID: 12788, Command line: git.exe  --version
8:57:21.0	git.exe	12788	Process Start		SUCCESS	"Parent PID: 12780, Command =
line: git.exe  --version, Current directory: C:\Users\gpierre\Desktop\, Env=
ironment:=20
8:57:21.0	git.exe	12788	Thread Create		SUCCESS	Thread ID: 12792
...

After that the processes exit one by one (all with error code 1) in reverse=
 order:

...
8:57:48.6	git.exe	12788	Thread Exit		SUCCESS	Thread ID: 12792, User Time: 0=
.0000000, Kernel Time: 0.0312002
8:57:48.6	git.exe	12788	Process Exit		SUCCESS	Exit Status: 1, User Time: 0.=
0000000 seconds, Kernel Time: 0.0312002 seconds, Private Bytes: 1,576,960, =
Peak Private Bytes: 1,654,784, Working Set: 4,235,264, Peak Working Set: 4,=
272,128
8:57:48.6	git.exe	12780	Thread Exit		SUCCESS	Thread ID: 12784, User Time: 0=
.0000000, Kernel Time: 0.0312002
8:57:48.6	git.exe	12780	Process Exit		SUCCESS	Exit Status: 1, User Time: 0.=
0000000 seconds, Kernel Time: 0.0312002 seconds, Private Bytes: 1,597,440, =
Peak Private Bytes: 1,654,784, Working Set: 4,251,648, Peak Working Set: 4,=
288,512
8:57:48.6	git.exe	12772	Thread Exit		SUCCESS	Thread ID: 12776, User Time: 0=
.0000000, Kernel Time: 0.0312002
8:57:48.6	git.exe	12772	Process Exit		SUCCESS	Exit Status: 1, User Time: 0.=
0000000 seconds, Kernel Time: 0.0312002 seconds, Private Bytes: 1,601,536, =
Peak Private Bytes: 1,642,496, Working Set: 4,304,896, Peak Working Set: 4,=
341,760
8:57:48.6	git.exe	12764	Thread Exit		SUCCESS	Thread ID: 12768, User Time: 0=
.0156001, Kernel Time: 0.0312002
8:57:48.6	git.exe	12764	Process Exit		SUCCESS	Exit Status: 1, User Time: 0.=
0156001 seconds, Kernel Time: 0.0468003 seconds, Private Bytes: 1,597,440, =
Peak Private Bytes: 1,638,400, Working Set: 4,263,936, Peak Working Set: 4,=
300,800
8:57:48.6	git.exe	12756	Thread Exit		SUCCESS	Thread ID: 12760, User Time: 0=
.0000000, Kernel Time: 0.0156001
8:57:48.6	git.exe	12756	Process Exit		SUCCESS	Exit Status: 1, User Time: 0.=
0000000 seconds, Kernel Time: 0.0156001 seconds, Private Bytes: 1,581,056, =
Peak Private Bytes: 1,642,496, Working Set: 4,222,976, Peak Working Set: 4,=
259,840
8:57:48.6	git.exe	12744	Thread Exit		SUCCESS	Thread ID: 12748, User Time: 0=
.0000000, Kernel Time: 0.0312002
8:57:48.6	git.exe	12744	Process Exit		SUCCESS	Exit Status: 1, User Time: 0.=
0000000 seconds, Kernel Time: 0.0312002 seconds, Private Bytes: 1,560,576, =
Peak Private Bytes: 1,650,688, Working Set: 4,231,168, Peak Working Set: 4,=
308,992

---------------------------------------------------------------------------=
-
I never saw that before, it seems every command is doing that (tried status=
, log, init, fetch).
It happened to me before that GitExtensions or Visual Studio would spawn a =
lot of git processes, but nothing like this.
I'm wondering if there is a glitch in the code that would allow git.exe to =
call itself with same arguments, leading to an (quasi) endless loop of call=
s.
Let me know what I can do to help isolating the problem, I'll assist if pos=
sible.

---------------------------------------------------------------------------=
-
For reference, here is what the built-in git --version is doing from git ba=
sh, only two processes are spawned, git --version first (the command line),=
 then git rev-parse, and then the process exits:

9:55:51.2	git.exe	5604	Process Start		SUCCESS	"Parent PID: 752, Command lin=
e: ""C:\Program Files\Git\mingw64\bin\git.exe"" --version, Current director=
y: C:\Users\gpierre\, Environment:=20
;	ACLOCAL_PATH=3DC:\Program Files\Git\mingw64\share\aclocal;C:\Program File=
s\Git\usr\share\aclocal
;	ALLUSERSPROFILE=3DC:\ProgramData
;	APPDATA=3DC:\Users\gpierre\AppData\Roaming
;	COMMONPROGRAMFILES=3DC:\Program Files\Common Files
;	COMPUTERNAME=3D
;	COMSPEC=3DC:\windows\system32\cmd.exe
;	CONFIG_SITE=3DC:/Program Files/Git/mingw64/etc/config.site
;	CommonProgramFiles(x86)=3DC:\Program Files (x86)\Common Files
;	CommonProgramW6432=3DC:\Program Files\Common Files
;	DEFLOGDIR=3DC:\ProgramData\McAfee\Endpoint Security\Logs
;	DISPLAY=3Dneeds-to-be-defined
;	EXEPATH=3DC:\Program Files\Git
;	FP_NO_HOST_CHECK=3DNO
;	GTK_BASEPATH=3DC:\Program Files (x86)\GtkSharp\2.12\
;	HOME=3DC:\Users\gpierre
;	HOMEDRIVE=3DC:
;	HOMEPATH=3D\Users\gpierre
;	HOSTNAME=3D
;	HasSCCM2012Client=3D1
;	INFOPATH=3DC:\Program Files\Git\usr\local\info;C:\Program Files\Git\usr\s=
hare\info;C:\Program Files\Git\usr\info;C:\Program Files\Git\share\info
;	LANG=3Den_US.UTF-8
;	LOCALAPPDATA=3DC:\Users\gpierre\AppData\Local
;	LOGONSERVER=3D\\
;	MANPATH=3DC:\Program Files\Git\mingw64\local\man;C:\Program Files\Git\min=
gw64\share\man;C:\Program Files\Git\usr\local\man;C:\Program Files\Git\usr\=
share\man;C:\Program Files\Git\usr\man;C:\Program Files\Git\share\man
;	MINGW_CHOST=3Dx86_64-w64-mingw32
;	MINGW_PACKAGE_PREFIX=3Dmingw-w64-x86_64
;	MINGW_PREFIX=3DC:/Program Files/Git/mingw64
;	MSYSTEM=3DMINGW64
;	MSYSTEM_CARCH=3Dx86_64
;	MSYSTEM_CHOST=3Dx86_64-w64-mingw32
;	MSYSTEM_PREFIX=3DC:/Program Files/Git/mingw64
;	NUMBER_OF_PROCESSORS=3D4
;	ORIGINAL_PATH=3DC:\Program Files\Git\mingw64\bin;C:\Program Files\Git\usr=
\bin;C:\Users\gpierre\bin;C:\ProgramData\Oracle\Java\javapath;C:\windows\sy=
stem32;C:\windows;C:\windows\System32\Wbem;C:\windows\System32\WindowsPower=
Shell\v1.0;C:\Program Files\Dell\Dell Data Protection\Encryption;C:\Program=
 Files (x86)\NVIDIA Corporation\PhysX\Common;C:\Program Files\Microsoft SQL=
 Server\130\Tools\Binn;C:\Program Files\dotnet;C:\Program Files (x86)\GtkSh=
arp\2.12\bin;C:\Users\gpierre\.dnx\bin;C:\Program Files\Microsoft DNX\Dnvm;=
C:\EASE\APEX12-4.4.0\bin;C:\EASE\APEX12-4.4.0\platforms\default\DEOS;C:\Pro=
gram Files\PuTTY;C:\windows\System32\WindowsPowerShell\v1.0;C:\windows\Syst=
em32\WindowsPowerShell\v1.0;C:\Program Files\1E\NomadBranch;C:\HashiCorp\Va=
grant\bin;C:\windows\System32\WindowsPowerShell\v1.0
;	ORIGINAL_TEMP=3DC:/Users/gpierre/AppData/Local/Temp
;	ORIGINAL_TMP=3DC:/Users/gpierre/AppData/Local/Temp
;	OS=3DWindows_NT
;	PATH=3DC:\Users\gpierre\bin;C:\Program Files\Git\mingw64\bin;C:\Program F=
iles\Git\usr\local\bin;C:\Program Files\Git\usr\bin;C:\Program Files\Git\us=
r\bin;C:\Program Files\Git\mingw64\bin;C:\Program Files\Git\usr\bin;C:\User=
s\gpierre\bin;C:\ProgramData\Oracle\Java\javapath;C:\windows\system32;C:\wi=
ndows;C:\windows\System32\Wbem;C:\windows\System32\WindowsPowerShell\v1.0;C=
:\Program Files\Dell\Dell Data Protection\Encryption;C:\Program Files (x86)=
\NVIDIA Corporation\PhysX\Common;C:\Program Files\Microsoft SQL Server\130\=
Tools\Binn;C:\Program Files\dotnet;C:\Program Files (x86)\GtkSharp\2.12\bin=
;C:\Users\gpierre\.dnx\bin;C:\Program Files\Microsoft DNX\Dnvm;C:\EASE\APEX=
12-4.4.0\bin;C:\EASE\APEX12-4.4.0\platforms\default\DEOS;C:\Program Files\P=
uTTY;C:\windows\System32\WindowsPowerShell\v1.0;C:\windows\System32\Windows=
PowerShell\v1.0;C:\Program Files\1E\NomadBranch;C:\HashiCorp\Vagrant\bin;C:=
\windows\System32\WindowsPowerShell\v1.0;C:\Program Files\Git\usr\bin\vendo=
r_perl;C:\Program Files\Git\usr\bin\core_perl
;	PATHEXT=3D.COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC
;	PKG_CONFIG_PATH=3DC:\Program Files\Git\mingw64\lib\pkgconfig;C:\Program F=
iles\Git\mingw64\share\pkgconfig
;	PLINK_PROTOCOL=3Dssh
;	PROCESSOR_ARCHITECTURE=3DAMD64
;	PROCESSOR_IDENTIFIER=3DIntel64 Family 6 Model 94 Stepping 3, GenuineIntel
;"
9:55:51.2	git.exe	5604	Thread Create		SUCCESS	Thread ID: 8844
9:55:51.2	git.exe	5604	Load Image	C:\Program Files\Git\mingw64\bin\git.exe	=
SUCCESS	Image Base: 0x1160000, Image Size: 0x2f0000
9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\ntdll.dll	SUCCESS	Ima=
ge Base: 0x77250000, Image Size: 0x19f000
9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\kernel32.dll	SUCCESS	=
Image Base: 0x77130000, Image Size: 0x11f000
9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\KernelBase.dll	SUCCES=
S	Image Base: 0x7fefcde0000, Image Size: 0x6a000
9:55:51.2	git.exe	5604	Load Image	C:\Program Files\Git\mingw64\bin\libiconv=
-2.dll	SUCCESS	Image Base: 0x66000000, Image Size: 0x10b000
9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\msvcrt.dll	SUCCESS	Im=
age Base: 0x7fefd950000, Image Size: 0x9f000
9:55:51.2	git.exe	5604	Load Image	C:\Program Files\Git\mingw64\bin\libintl-=
8.dll	SUCCESS	Image Base: 0x61cc0000, Image Size: 0x28000
9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\advapi32.dll	SUCCESS	=
Image Base: 0x7fefd7d0000, Image Size: 0xdb000
9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\sechost.dll	SUCCESS	I=
mage Base: 0x7feff520000, Image Size: 0x1f000
9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\rpcrt4.dll	SUCCESS	Im=
age Base: 0x7fefebf0000, Image Size: 0x12d000
9:55:51.2	git.exe	5604	Load Image	C:\Program Files\Git\mingw64\bin\libpcre2=
-8-0.dll	SUCCESS	Image Base: 0x64380000, Image Size: 0x54000
9:55:51.2	git.exe	5604	Load Image	C:\Program Files\Git\mingw64\bin\zlib1.dl=
l	SUCCESS	Image Base: 0x62e80000, Image Size: 0x1f000
9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\user32.dll	SUCCESS	Im=
age Base: 0x77030000, Image Size: 0xfa000
9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\gdi32.dll	SUCCESS	Ima=
ge Base: 0x7fefd6c0000, Image Size: 0x67000
9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\lpk.dll	SUCCESS	Image=
 Base: 0x7fefd290000, Image Size: 0xe000
9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\usp10.dll	SUCCESS	Ima=
ge Base: 0x7fefd5f0000, Image Size: 0xcb000
9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\ws2_32.dll	SUCCESS	Im=
age Base: 0x7fefd240000, Image Size: 0x4d000
9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\nsi.dll	SUCCESS	Image=
 Base: 0x7fefed50000, Image Size: 0x8000
9:55:51.2	git.exe	5604	Load Image	C:\Program Files\Git\mingw64\bin\libssp-0=
.dll	SUCCESS	Image Base: 0x68ac0000, Image Size: 0xe000
9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\imm32.dll	SUCCESS	Ima=
ge Base: 0x7fefed20000, Image Size: 0x2e000
9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\msctf.dll	SUCCESS	Ima=
ge Base: 0x7feff410000, Image Size: 0x109000
9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\nvinitx.dll	SUCCESS	I=
mage Base: 0x7fefccd0000, Image Size: 0x31000
9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\version.dll	SUCCESS	I=
mage Base: 0x7fefccc0000, Image Size: 0xc000
9:55:51.3	git.exe	5604	Load Image	C:\Windows\System32\cryptsp.dll	SUCCESS	I=
mage Base: 0x7fefc530000, Image Size: 0x18000
9:55:51.3	git.exe	5604	Load Image	C:\Windows\System32\rsaenh.dll	SUCCESS	Im=
age Base: 0x7fefc230000, Image Size: 0x47000
9:55:51.3	git.exe	5604	Load Image	C:\Windows\System32\cryptbase.dll	SUCCESS=
	Image Base: 0x7fefcbf0000, Image Size: 0xf000
9:55:51.3	git.exe	5604	Thread Exit		SUCCESS	Thread ID: 8844, User Time: 0.0=
000000, Kernel Time: 0.0468003
9:55:51.3	git.exe	5604	Process Exit		SUCCESS	Exit Status: 0, User Time: 0.0=
000000 seconds, Kernel Time: 0.0468003 seconds, Private Bytes: 2,940,928, P=
eak Private Bytes: 2,981,888, Working Set: 4,980,736, Peak Working Set: 4,9=
80,736
9:55:51.6	git.exe	5560	Process Start		SUCCESS	"Parent PID: 9080, Command li=
ne: ""C:\Program Files\Git\mingw64\bin\git.exe"" rev-parse --git-dir --is-i=
nside-git-dir --is-bare-repository --is-inside-work-tree --short HEAD, Curr=
ent directory: C:\Users\gpierre\, Environment:=20
9:55:51.6	git.exe	5560	Thread Create		SUCCESS	Thread ID: 5248
9:55:51.6	git.exe	5560	Load Image	C:\Program Files\Git\mingw64\bin\git.exe	=
SUCCESS	Image Base: 0x190000, Image Size: 0x2f0000
9:55:51.6	git.exe	5560	Load Image	C:\Windows\System32\ntdll.dll	SUCCESS	Ima=
ge Base: 0x77250000, Image Size: 0x19f000
9:55:51.6	git.exe	5560	Load Image	C:\Windows\System32\kernel32.dll	SUCCESS	=
Image Base: 0x77130000, Image Size: 0x11f000
9:55:51.6	git.exe	5560	Load Image	C:\Windows\System32\KernelBase.dll	SUCCES=
S	Image Base: 0x7fefcde0000, Image Size: 0x6a000
9:55:51.6	git.exe	5560	Load Image	C:\Program Files\Git\mingw64\bin\libiconv=
-2.dll	SUCCESS	Image Base: 0x66000000, Image Size: 0x10b000
9:55:51.6	git.exe	5560	Load Image	C:\Windows\System32\msvcrt.dll	SUCCESS	Im=
age Base: 0x7fefd950000, Image Size: 0x9f000
9:55:51.6	git.exe	5560	Load Image	C:\Program Files\Git\mingw64\bin\libintl-=
8.dll	SUCCESS	Image Base: 0x61cc0000, Image Size: 0x28000
9:55:51.6	git.exe	5560	Load Image	C:\Windows\System32\advapi32.dll	SUCCESS	=
Image Base: 0x7fefd7d0000, Image Size: 0xdb000
9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\sechost.dll	SUCCESS	I=
mage Base: 0x7feff520000, Image Size: 0x1f000
9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\rpcrt4.dll	SUCCESS	Im=
age Base: 0x7fefebf0000, Image Size: 0x12d000
9:55:51.7	git.exe	5560	Load Image	C:\Program Files\Git\mingw64\bin\libpcre2=
-8-0.dll	SUCCESS	Image Base: 0x64380000, Image Size: 0x54000
9:55:51.7	git.exe	5560	Load Image	C:\Program Files\Git\mingw64\bin\zlib1.dl=
l	SUCCESS	Image Base: 0x62e80000, Image Size: 0x1f000
9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\user32.dll	SUCCESS	Im=
age Base: 0x77030000, Image Size: 0xfa000
9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\gdi32.dll	SUCCESS	Ima=
ge Base: 0x7fefd6c0000, Image Size: 0x67000
9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\lpk.dll	SUCCESS	Image=
 Base: 0x7fefd290000, Image Size: 0xe000
9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\usp10.dll	SUCCESS	Ima=
ge Base: 0x7fefd5f0000, Image Size: 0xcb000
9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\ws2_32.dll	SUCCESS	Im=
age Base: 0x7fefd240000, Image Size: 0x4d000
9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\nsi.dll	SUCCESS	Image=
 Base: 0x7fefed50000, Image Size: 0x8000
9:55:51.7	git.exe	5560	Load Image	C:\Program Files\Git\mingw64\bin\libssp-0=
.dll	SUCCESS	Image Base: 0x68ac0000, Image Size: 0xe000
9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\imm32.dll	SUCCESS	Ima=
ge Base: 0x7fefed20000, Image Size: 0x2e000
9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\msctf.dll	SUCCESS	Ima=
ge Base: 0x7feff410000, Image Size: 0x109000
9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\nvinitx.dll	SUCCESS	I=
mage Base: 0x7fefccd0000, Image Size: 0x31000
9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\version.dll	SUCCESS	I=
mage Base: 0x7fefccc0000, Image Size: 0xc000
9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\cryptsp.dll	SUCCESS	I=
mage Base: 0x7fefc530000, Image Size: 0x18000
9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\rsaenh.dll	SUCCESS	Im=
age Base: 0x7fefc230000, Image Size: 0x47000
9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\cryptbase.dll	SUCCESS=
	Image Base: 0x7fefcbf0000, Image Size: 0xf000
9:55:51.7	git.exe	5560	Thread Exit		SUCCESS	Thread ID: 5248, User Time: 0.0=
000000, Kernel Time: 0.0780005
9:55:51.7	git.exe	5560	Process Exit		SUCCESS	Exit Status: 128, User Time: 0=
.0000000 seconds, Kernel Time: 0.0780005 seconds, Private Bytes: 2,932,736,=
 Peak Private Bytes: 2,973,696, Working Set: 5,062,656, Peak Working Set: 5=
,062,656


Thanks a lot! Cheers,
Pierre G.

