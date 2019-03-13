Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A46A120248
	for <e@80x24.org>; Wed, 13 Mar 2019 13:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfCMN6v (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 09:58:51 -0400
Received: from mail-eopbgr750118.outbound.protection.outlook.com ([40.107.75.118]:33093
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726748AbfCMN6v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 09:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ontextron.onmicrosoft.com; s=selector1-trusimulation-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMyhQ/HpnTv2h0aqIAxTbC8BlwqAjuZmTaCI37gYtr0=;
 b=PKTFtKl9hIsqFmHMPfbNTpVCcEyZgi4XEuBgS2DjK/GUxEwacmSzc/nXuMDg/Fi0LBBp+6uUq03HbkXqVP4x4WzDoD4R5ypnwmufD8Yz0NE098//qbJQkubwTw7FYkgcm3HkCAWBVQcBasZUxi2PIU5BJLQz9vb4EHANx3r/kxo=
Received: from SN6PR03MB3647.namprd03.prod.outlook.com (52.135.80.148) by
 SN6PR03MB3808.namprd03.prod.outlook.com (52.135.100.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Wed, 13 Mar 2019 13:58:41 +0000
Received: from SN6PR03MB3647.namprd03.prod.outlook.com
 ([fe80::151b:3a78:63f:8308]) by SN6PR03MB3647.namprd03.prod.outlook.com
 ([fe80::151b:3a78:63f:8308%5]) with mapi id 15.20.1709.011; Wed, 13 Mar 2019
 13:58:41 +0000
From:   "Garcia, Pierre" <pgarcia@trusimulation.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Bug: git for Windows spawning a lot of processes recursively
Thread-Topic: Bug: git for Windows spawning a lot of processes recursively
Thread-Index: AdTKX37R6NVOZpIeSUOzs9W/WhkzYALkcTcAAIgDrqAAQ7ifgAAhFBqQ
Date:   Wed, 13 Mar 2019 13:58:40 +0000
Message-ID: <SN6PR03MB364786545AA1170012EEB5F9BA4A0@SN6PR03MB3647.namprd03.prod.outlook.com>
References: <SN6PR03MB3647F1CDFD95F29C86F54FF8BA7F0@SN6PR03MB3647.namprd03.prod.outlook.com>
 <nycvar.QRO.7.76.6.1903082154320.41@tvgsbejvaqbjf.bet>
 <SN6PR03MB364776AC6AB063BFEA7F3310BA480@SN6PR03MB3647.namprd03.prod.outlook.com>
 <nycvar.QRO.7.76.6.1903122308110.41@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1903122308110.41@tvgsbejvaqbjf.bet>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pgarcia@trusimulation.com; 
x-originating-ip: [32.66.32.13]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c138e914-c239-43b4-8995-08d6a7bbffcb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:SN6PR03MB3808;
x-ms-traffictypediagnostic: SN6PR03MB3808:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR03MB3808C9CC05A793E25444376ABA4A0@SN6PR03MB3808.namprd03.prod.outlook.com>
x-forefront-prvs: 09752BC779
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(39860400002)(376002)(346002)(51914003)(189003)(13464003)(199004)(68736007)(6116002)(71200400001)(71190400001)(6436002)(8936002)(106356001)(45080400002)(66066001)(105586002)(97736004)(14444005)(256004)(3846002)(6916009)(6306002)(55016002)(9686003)(229853002)(6246003)(5660300002)(52536013)(33656002)(53936002)(53946003)(30864003)(76176011)(25786009)(347745004)(316002)(81166006)(81156014)(99286004)(966005)(8676002)(4326008)(74316002)(14454004)(478600001)(93886005)(7736002)(86362001)(305945005)(102836004)(446003)(26005)(486006)(476003)(11346002)(53546011)(186003)(6506007)(2906002)(7696005)(559001)(579004)(460985005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR03MB3808;H:SN6PR03MB3647.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: trusimulation.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QzzKWPkvijTo3XKHS4gz0+vQbPMR+5YZWdTnJ3QLR15D1bfCxIujXDbCPn4CBy8w7TWTKGHygsEYjyn+HT9Q7HSKuvO/WAn4rwjxB7i3CMkMO+utzCzTAnXAEFPhKgXinRMfbY2eklgtMRdqU6SWXdmBHkXpxq9ZzRpXFtdP4cZwJF9pEjxLyjWM/I8kG0xpe7jXMWjFZtQC1erFsLzRNmkuvMSm416tI4FahdAztJPCebUBRMH+1BMn9VmK4V2+0OlThkYGqXWx6oFzN+vWsQa6CC2N/s81a4QXyciNzK6anReaZDynPv6L6sQBN4I9fHUJmgHXytQG7z/hsE2G5ETWK7KM8WnbjgtY339QLvlNOsC9OzhqMvSj3xp8wDd5cluEmKPXfTfTrD4PfirUOHXnoOc1E1QHRQripSCopmc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: trusimulation.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c138e914-c239-43b4-8995-08d6a7bbffcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2019 13:58:40.9924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2d5b202c-8c07-4168-a551-66f570d429b3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3808
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Great, thanks for the feedback.
Version 2.21 was also working BTW.
Bye
Pierre

-----Original Message-----
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>=20
Sent: Tuesday, March 12, 2019 18:09
To: Garcia, Pierre <pgarcia@trusimulation.com>
Cc: git@vger.kernel.org
Subject: RE: Bug: git for Windows spawning a lot of processes recursively

Hi Pierre,

On Mon, 11 Mar 2019, Garcia, Pierre wrote:

> Hello Johannes,
>=20
> I installed the following snapshot on the problematic machine:
> Sun, 10 Mar 2019 17:37:25 +0100
> (commit eb5d06f545)
> Git for Windows installer: 64-bit
>=20
> And the problem is gone! No more issue!

Thank you for confirming!

> At the time I had the issue I was on field trip with limited time and no =
other version to try at hand - as a workaround I ended up having GitExtensi=
on point to the mingw64 binary and it worked normally.
> I tried the exact same version that caused the problem on the laptop, on =
another machine and I didn't get the issue this time, so the problem might =
be tied to a very specific setup.

IIRC we fixed some potentially unterminated string recently, and that might=
 be the fix for your problem.

In any case, I won't worry about it now ;-)

Ciao,
Johannes

>=20
> Cheers,
> Pierre
>=20
> -----Original Message-----
> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Sent: Friday, March 08, 2019 15:56
> To: Garcia, Pierre <pgarcia@trusimulation.com>
> Cc: git@vger.kernel.org
> Subject: Re: Bug: git for Windows spawning a lot of processes=20
> recursively
>=20
> Hi Pierre,
>=20
> On Fri, 22 Feb 2019, Garcia, Pierre wrote:
>=20
> > I'd like to report an issue with git for Windows
> >=20
> > Git version 2.20.1
> > Windows 7 x64 (Build 7601: Service Pack 1)
> >=20
> > --------------------------------------------------------------------
> > --
> > ------
> > Issue:
> > When running from Git-bash (not even inside a repo), git commands=20
> > from built-in are OK, but if I use the exe that is located at=20
> > C:\Program Files\Git\bin\git.exe, the process takes long to execute=20
> > and then exits with error "error launching git: The filename or=20
> > extension is too
> > long.":
>=20
> Is this still happening with v2.21.0? Or for that matter, with the latest=
 snapshot at https://wingit.blob.core.windows.net/files/index.html?
>=20
> Ciao,
> Johannes
>=20
> >=20
> > $ git --version
> > git version 2.20.1.windows.1
> >=20
> > $ which git
> > /mingw64/bin/git
> >=20
> > $ /c/Program\ Files/Git/bin/git.exe --version error launching git:=20
> > The filename or extension is too long.
> >=20
> > --------------------------------------------------------------------
> > --
> > ------ It started out of the blue, nothing special was done on the=20
> > computer, the previous day I cloned some repos, the next it was not wor=
king anymore.
> > I tried uninstall-reinstall with no success.
> > I'm using Gitextensions as well, but I verified that the problem was oc=
curring without Gitextensions (uninstalled at the time the traces were take=
n).
> >=20
> > --------------------------------------------------------------------
> > --
> > ------ I ran procmon.exe to monitor the activity of the process and=20
> > I found out that git.exe was spawning itself 385 times in total in the =
trace I took, until all processes exit with error code 1, here is an extrac=
t of the procmon trace, showing thread and process activity for git.exe (I =
have more exhaustive trace but the file is quite big), I included the envir=
onment variables on the first call:
> >=20
> > Time of Day	Process Name	PID	Operation	Path	Result	Detail
> > 8:57:20.7	git.exe	12744	Process Start		SUCCESS	"Parent PID: 8412, Comma=
nd line: ""C:\Program Files\Git\bin\git.exe""  --version, Current directory=
: C:\Users\gpierre\Desktop\, Environment:=20
> > ;	=3D::=3D::\
> > ;	=3DC:=3DC:\Users\gpierre\Desktop
> > ;	=3DExitCode=3D00000001
> > ;	ALLUSERSPROFILE=3DC:\ProgramData
> > ;	CommonProgramFiles=3DC:\Program Files\Common Files
> > ;	CommonProgramFiles(x86)=3DC:\Program Files (x86)\Common Files
> > ;	CommonProgramW6432=3DC:\Program Files\Common Files
> > ;	ComSpec=3DC:\windows\system32\cmd.exe
> > ;	DEFLOGDIR=3DC:\ProgramData\McAfee\Endpoint Security\Logs
> > ;	FP_NO_HOST_CHECK=3DNO
> > ;	GTK_BASEPATH=3DC:\Program Files (x86)\GtkSharp\2.12\
> > ;	HasSCCM2012Client=3D1
> > ;	HOME=3DC:\Users\gpierre
> > ;	HOMEDRIVE=3DC:
> > ;	HOMEPATH=3D\Users\gpierre
> > ;	HOMESHARE=3DC:\Users\gpierre
> > ;	LOCALAPPDATA=3DC:\Users\gpierre\AppData\Local
> > ;	NUMBER_OF_PROCESSORS=3D4
> > ;	OS=3DWindows_NT
> > ;	Path=3DC:\ProgramData\Oracle\Java\javapath;C:\windows\system32;C:\win=
dows;C:\windows\System32\Wbem;C:\windows\System32\WindowsPowerShell\v1.0\;C=
:\Program Files\Dell\Dell Data Protection\Encryption\;C:\Program Files (x86=
)\NVIDIA Corporation\PhysX\Common;C:\Program Files\Microsoft SQL Server\130=
\Tools\Binn\;C:\Program Files\dotnet\;C:\Program Files (x86)\GtkSharp\2.12\=
bin;C:\windows\system32\config\systemprofile\.dnx\bin;C:\Program Files\Micr=
osoft DNX\Dnvm\;C:\EASE\APEX12-4.4.0\bin;C:\EASE\APEX12-4.4.0\platforms\def=
ault\DEOS;C:\Program Files\PuTTY\;C:\windows\System32\WindowsPowerShell\v1.=
0\;C:\windows\System32\WindowsPowerShell\v1.0\;C:\Program Files\1E\NomadBra=
nch\;C:\HashiCorp\Vagrant\bin;C:\windows\System32\WindowsPowerShell\v1.0\
> > ;	PATHEXT=3D.COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC
> > ;	PROCESSOR_ARCHITECTURE=3DAMD64
> > ;	PROCESSOR_IDENTIFIER=3DIntel64 Family 6 Model 94 Stepping 3, GenuineI=
ntel
> > ;	PROCESSOR_LEVEL=3D6
> > ;	PROCESSOR_REVISION=3D5e03
> > ;	ProgramData=3DC:\ProgramData
> > ;	ProgramFiles=3DC:\Program Files
> > ;	ProgramFiles(x86)=3DC:\Program Files (x86)
> > ;	ProgramW6432=3DC:\Program Files
> > ;	PROMPT=3D$P$G
> > ;	PSModulePath=3DC:\Program Files\WindowsPowerShell\Modules;C:\windows\=
system32\WindowsPowerShell\v1.0\Modules
> > ;	PUBLIC=3DC:\Users\Public
> > ;	SESSIONNAME=3DConsole
> > ;	SNC_LIB=3Dgsskrb5.dll
> > ;	SOEDataPartition=3DC:
> > ;	SOEDesktopAdminModel=3DUser
> > ;	SOESystemPartitionLabel=3DSOE-Disk
> > ;	SystemDrive=3DC:
> > ;	SystemRoot=3DC:\windows
> > ;	TEMP=3DC:\Users\gpierre\AppData\Local\Temp
> > ;	TMP=3DC:\Users\gpierre\AppData\Local\Temp
> > ;	USERNAME=3Dgpierre
> > ;	USERPROFILE=3DC:\Users\gpierre
> > ;	VBOX_MSI_INSTALL_PATH=3DC:\Program Files\Oracle\VirtualBox\
> > ;	VS140COMNTOOLS=3DC:\Program Files (x86)\Microsoft Visual Studio 14.0\=
Common7\Tools\
> > ;	VS80COMNTOOLS=3DC:\Program Files (x86)\Microsoft Visual Studio 8\Comm=
on7\Tools\
> > ;	windir=3DC:\windows
> > ;	windows_tracing_flags=3D3
> > ;	windows_tracing_logfile=3DC:\BVTBin\Tests\installpackage\csilogfile.l=
og"
> > 8:57:20.7	git.exe	12744	Thread Create		SUCCESS	Thread ID: 12748
> > 8:57:20.7	git.exe	12744	Load Image	C:\Program Files\Git\bin\git.exe	SUC=
CESS	Image Base: 0x13a0000, Image Size: 0x52000
> > 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\ntdll.dll	SUCCES=
S	Image Base: 0x77b70000, Image Size: 0x19f000
> > 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\kernel32.dll	SUC=
CESS	Image Base: 0x77950000, Image Size: 0x11f000
> > 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\KernelBase.dll	S=
UCCESS	Image Base: 0x7fefd860000, Image Size: 0x6a000
> > 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\msvcrt.dll	SUCCE=
SS	Image Base: 0x7fefef60000, Image Size: 0x9f000
> > 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\shell32.dll	SUCC=
ESS	Image Base: 0x7fefdc20000, Image Size: 0xd8a000
> > 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\shlwapi.dll	SUCC=
ESS	Image Base: 0x7feffde0000, Image Size: 0x71000
> > 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\gdi32.dll	SUCCES=
S	Image Base: 0x7fefdae0000, Image Size: 0x67000
> > 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\user32.dll	SUCCE=
SS	Image Base: 0x77a70000, Image Size: 0xfa000
> > 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\lpk.dll	SUCCESS	=
Image Base: 0x7fefed30000, Image Size: 0xe000
> > 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\usp10.dll	SUCCES=
S	Image Base: 0x7fefdb50000, Image Size: 0xcb000
> > 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\imm32.dll	SUCCES=
S	Image Base: 0x7fefe9b0000, Image Size: 0x2e000
> > 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\msctf.dll	SUCCES=
S	Image Base: 0x7fefed40000, Image Size: 0x109000
> > 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\nvinitx.dll	SUCC=
ESS	Image Base: 0x7fefd5f0000, Image Size: 0x31000
> > 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\version.dll	SUCC=
ESS	Image Base: 0x7fefd5e0000, Image Size: 0xc000
> > 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\advapi32.dll	SUC=
CESS	Image Base: 0x7fefec50000, Image Size: 0xdb000
> > 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\sechost.dll	SUCC=
ESS	Image Base: 0x7fefee50000, Image Size: 0x1f000
> > 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\rpcrt4.dll	SUCCE=
SS	Image Base: 0x7feff6b0000, Image Size: 0x12d000
> > 8:57:20.8	git.exe	12744	Process Create	C:\Program Files\Git\bin\git.exe=
	SUCCESS	PID: 12756, Command line: git.exe  --version
> > 8:57:20.8	git.exe	12756	Process Start		SUCCESS	"Parent PID: 12744, Comm=
and line: git.exe  --version, Current directory: C:\Users\gpierre\Desktop\,=
 Environment:=20
> > 8:57:20.8	git.exe	12756	Thread Create		SUCCESS	Thread ID: 12760
> >=20
> > This repeats 385 times (I removed the Load Image lines):
> >=20
> > 8:57:20.9	git.exe	12756	Process Create	C:\Program Files\Git\bin\git.exe=
	SUCCESS	PID: 12764, Command line: git.exe  --version
> > 8:57:20.9	git.exe	12764	Process Start		SUCCESS	"Parent PID: 12756, Comm=
and line: git.exe  --version, Current directory: C:\Users\gpierre\Desktop\,=
 Environment:=20
> > 8:57:20.9	git.exe	12764	Thread Create		SUCCESS	Thread ID: 12768
> > 8:57:20.9	git.exe	12764	Process Create	C:\Program Files\Git\bin\git.exe=
	SUCCESS	PID: 12772, Command line: git.exe  --version
> > 8:57:20.9	git.exe	12772	Process Start		SUCCESS	"Parent PID: 12764, Comm=
and line: git.exe  --version, Current directory: C:\Users\gpierre\Desktop\,=
 Environment:=20
> > 8:57:20.9	git.exe	12772	Thread Create		SUCCESS	Thread ID: 12776
> > 8:57:21.0	git.exe	12772	Process Create	C:\Program Files\Git\bin\git.exe=
	SUCCESS	PID: 12780, Command line: git.exe  --version
> > 8:57:21.0	git.exe	12780	Process Start		SUCCESS	"Parent PID: 12772, Comm=
and line: git.exe  --version, Current directory: C:\Users\gpierre\Desktop\,=
 Environment:=20
> > 8:57:21.0	git.exe	12780	Thread Create		SUCCESS	Thread ID: 12784
> > 8:57:21.0	git.exe	12780	Process Create	C:\Program Files\Git\bin\git.exe=
	SUCCESS	PID: 12788, Command line: git.exe  --version
> > 8:57:21.0	git.exe	12788	Process Start		SUCCESS	"Parent PID: 12780, Comm=
and line: git.exe  --version, Current directory: C:\Users\gpierre\Desktop\,=
 Environment:=20
> > 8:57:21.0	git.exe	12788	Thread Create		SUCCESS	Thread ID: 12792
> > ...
> >=20
> > After that the processes exit one by one (all with error code 1) in rev=
erse order:
> >=20
> > ...
> > 8:57:48.6	git.exe	12788	Thread Exit		SUCCESS	Thread ID: 12792, User Tim=
e: 0.0000000, Kernel Time: 0.0312002
> > 8:57:48.6	git.exe	12788	Process Exit		SUCCESS	Exit Status: 1, User Time=
: 0.0000000 seconds, Kernel Time: 0.0312002 seconds, Private Bytes: 1,576,9=
60, Peak Private Bytes: 1,654,784, Working Set: 4,235,264, Peak Working Set=
: 4,272,128
> > 8:57:48.6	git.exe	12780	Thread Exit		SUCCESS	Thread ID: 12784, User Tim=
e: 0.0000000, Kernel Time: 0.0312002
> > 8:57:48.6	git.exe	12780	Process Exit		SUCCESS	Exit Status: 1, User Time=
: 0.0000000 seconds, Kernel Time: 0.0312002 seconds, Private Bytes: 1,597,4=
40, Peak Private Bytes: 1,654,784, Working Set: 4,251,648, Peak Working Set=
: 4,288,512
> > 8:57:48.6	git.exe	12772	Thread Exit		SUCCESS	Thread ID: 12776, User Tim=
e: 0.0000000, Kernel Time: 0.0312002
> > 8:57:48.6	git.exe	12772	Process Exit		SUCCESS	Exit Status: 1, User Time=
: 0.0000000 seconds, Kernel Time: 0.0312002 seconds, Private Bytes: 1,601,5=
36, Peak Private Bytes: 1,642,496, Working Set: 4,304,896, Peak Working Set=
: 4,341,760
> > 8:57:48.6	git.exe	12764	Thread Exit		SUCCESS	Thread ID: 12768, User Tim=
e: 0.0156001, Kernel Time: 0.0312002
> > 8:57:48.6	git.exe	12764	Process Exit		SUCCESS	Exit Status: 1, User Time=
: 0.0156001 seconds, Kernel Time: 0.0468003 seconds, Private Bytes: 1,597,4=
40, Peak Private Bytes: 1,638,400, Working Set: 4,263,936, Peak Working Set=
: 4,300,800
> > 8:57:48.6	git.exe	12756	Thread Exit		SUCCESS	Thread ID: 12760, User Tim=
e: 0.0000000, Kernel Time: 0.0156001
> > 8:57:48.6	git.exe	12756	Process Exit		SUCCESS	Exit Status: 1, User Time=
: 0.0000000 seconds, Kernel Time: 0.0156001 seconds, Private Bytes: 1,581,0=
56, Peak Private Bytes: 1,642,496, Working Set: 4,222,976, Peak Working Set=
: 4,259,840
> > 8:57:48.6	git.exe	12744	Thread Exit		SUCCESS	Thread ID: 12748, User Tim=
e: 0.0000000, Kernel Time: 0.0312002
> > 8:57:48.6	git.exe	12744	Process Exit		SUCCESS	Exit Status: 1, User Time=
: 0.0000000 seconds, Kernel Time: 0.0312002 seconds, Private Bytes: 1,560,5=
76, Peak Private Bytes: 1,650,688, Working Set: 4,231,168, Peak Working Set=
: 4,308,992
> >=20
> > --------------------------------------------------------------------
> > --
> > ------ I never saw that before, it seems every command is doing that=20
> > (tried status, log, init, fetch).
> > It happened to me before that GitExtensions or Visual Studio would spaw=
n a lot of git processes, but nothing like this.
> > I'm wondering if there is a glitch in the code that would allow git.exe=
 to call itself with same arguments, leading to an (quasi) endless loop of =
calls.
> > Let me know what I can do to help isolating the problem, I'll assist if=
 possible.
> >=20
> > --------------------------------------------------------------------
> > --
> > ------ For reference, here is what the built-in git --version is=20
> > doing from git bash, only two processes are spawned, git --version firs=
t (the command line), then git rev-parse, and then the process exits:
> >=20
> > 9:55:51.2	git.exe	5604	Process Start		SUCCESS	"Parent PID: 752, Command=
 line: ""C:\Program Files\Git\mingw64\bin\git.exe"" --version, Current dire=
ctory: C:\Users\gpierre\, Environment:=20
> > ;	ACLOCAL_PATH=3DC:\Program Files\Git\mingw64\share\aclocal;C:\Program =
Files\Git\usr\share\aclocal
> > ;	ALLUSERSPROFILE=3DC:\ProgramData
> > ;	APPDATA=3DC:\Users\gpierre\AppData\Roaming
> > ;	COMMONPROGRAMFILES=3DC:\Program Files\Common Files
> > ;	COMPUTERNAME=3D
> > ;	COMSPEC=3DC:\windows\system32\cmd.exe
> > ;	CONFIG_SITE=3DC:/Program Files/Git/mingw64/etc/config.site
> > ;	CommonProgramFiles(x86)=3DC:\Program Files (x86)\Common Files
> > ;	CommonProgramW6432=3DC:\Program Files\Common Files
> > ;	DEFLOGDIR=3DC:\ProgramData\McAfee\Endpoint Security\Logs
> > ;	DISPLAY=3Dneeds-to-be-defined
> > ;	EXEPATH=3DC:\Program Files\Git
> > ;	FP_NO_HOST_CHECK=3DNO
> > ;	GTK_BASEPATH=3DC:\Program Files (x86)\GtkSharp\2.12\
> > ;	HOME=3DC:\Users\gpierre
> > ;	HOMEDRIVE=3DC:
> > ;	HOMEPATH=3D\Users\gpierre
> > ;	HOSTNAME=3D
> > ;	HasSCCM2012Client=3D1
> > ;	INFOPATH=3DC:\Program Files\Git\usr\local\info;C:\Program Files\Git\u=
sr\share\info;C:\Program Files\Git\usr\info;C:\Program Files\Git\share\info
> > ;	LANG=3Den_US.UTF-8
> > ;	LOCALAPPDATA=3DC:\Users\gpierre\AppData\Local
> > ;	LOGONSERVER=3D\\
> > ;	MANPATH=3DC:\Program Files\Git\mingw64\local\man;C:\Program Files\Git=
\mingw64\share\man;C:\Program Files\Git\usr\local\man;C:\Program Files\Git\=
usr\share\man;C:\Program Files\Git\usr\man;C:\Program Files\Git\share\man
> > ;	MINGW_CHOST=3Dx86_64-w64-mingw32
> > ;	MINGW_PACKAGE_PREFIX=3Dmingw-w64-x86_64
> > ;	MINGW_PREFIX=3DC:/Program Files/Git/mingw64
> > ;	MSYSTEM=3DMINGW64
> > ;	MSYSTEM_CARCH=3Dx86_64
> > ;	MSYSTEM_CHOST=3Dx86_64-w64-mingw32
> > ;	MSYSTEM_PREFIX=3DC:/Program Files/Git/mingw64
> > ;	NUMBER_OF_PROCESSORS=3D4
> > ;	ORIGINAL_PATH=3DC:\Program Files\Git\mingw64\bin;C:\Program Files\Git=
\usr\bin;C:\Users\gpierre\bin;C:\ProgramData\Oracle\Java\javapath;C:\window=
s\system32;C:\windows;C:\windows\System32\Wbem;C:\windows\System32\WindowsP=
owerShell\v1.0;C:\Program Files\Dell\Dell Data Protection\Encryption;C:\Pro=
gram Files (x86)\NVIDIA Corporation\PhysX\Common;C:\Program Files\Microsoft=
 SQL Server\130\Tools\Binn;C:\Program Files\dotnet;C:\Program Files (x86)\G=
tkSharp\2.12\bin;C:\Users\gpierre\.dnx\bin;C:\Program Files\Microsoft DNX\D=
nvm;C:\EASE\APEX12-4.4.0\bin;C:\EASE\APEX12-4.4.0\platforms\default\DEOS;C:=
\Program Files\PuTTY;C:\windows\System32\WindowsPowerShell\v1.0;C:\windows\=
System32\WindowsPowerShell\v1.0;C:\Program Files\1E\NomadBranch;C:\HashiCor=
p\Vagrant\bin;C:\windows\System32\WindowsPowerShell\v1.0
> > ;	ORIGINAL_TEMP=3DC:/Users/gpierre/AppData/Local/Temp
> > ;	ORIGINAL_TMP=3DC:/Users/gpierre/AppData/Local/Temp
> > ;	OS=3DWindows_NT
> > ;	PATH=3DC:\Users\gpierre\bin;C:\Program Files\Git\mingw64\bin;C:\Progr=
am Files\Git\usr\local\bin;C:\Program Files\Git\usr\bin;C:\Program Files\Gi=
t\usr\bin;C:\Program Files\Git\mingw64\bin;C:\Program Files\Git\usr\bin;C:\=
Users\gpierre\bin;C:\ProgramData\Oracle\Java\javapath;C:\windows\system32;C=
:\windows;C:\windows\System32\Wbem;C:\windows\System32\WindowsPowerShell\v1=
.0;C:\Program Files\Dell\Dell Data Protection\Encryption;C:\Program Files (=
x86)\NVIDIA Corporation\PhysX\Common;C:\Program Files\Microsoft SQL Server\=
130\Tools\Binn;C:\Program Files\dotnet;C:\Program Files (x86)\GtkSharp\2.12=
\bin;C:\Users\gpierre\.dnx\bin;C:\Program Files\Microsoft DNX\Dnvm;C:\EASE\=
APEX12-4.4.0\bin;C:\EASE\APEX12-4.4.0\platforms\default\DEOS;C:\Program Fil=
es\PuTTY;C:\windows\System32\WindowsPowerShell\v1.0;C:\windows\System32\Win=
dowsPowerShell\v1.0;C:\Program Files\1E\NomadBranch;C:\HashiCorp\Vagrant\bi=
n;C:\windows\System32\WindowsPowerShell\v1.0;C:\Program Files\Git\usr\bin\v=
endor_perl;C:\Program Files\Git\usr\bin\core_perl
> > ;	PATHEXT=3D.COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC
> > ;	PKG_CONFIG_PATH=3DC:\Program Files\Git\mingw64\lib\pkgconfig;C:\Progr=
am Files\Git\mingw64\share\pkgconfig
> > ;	PLINK_PROTOCOL=3Dssh
> > ;	PROCESSOR_ARCHITECTURE=3DAMD64
> > ;	PROCESSOR_IDENTIFIER=3DIntel64 Family 6 Model 94 Stepping 3, GenuineI=
ntel
> > ;"
> > 9:55:51.2	git.exe	5604	Thread Create		SUCCESS	Thread ID: 8844
> > 9:55:51.2	git.exe	5604	Load Image	C:\Program Files\Git\mingw64\bin\git.=
exe	SUCCESS	Image Base: 0x1160000, Image Size: 0x2f0000
> > 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\ntdll.dll	SUCCESS=
	Image Base: 0x77250000, Image Size: 0x19f000
> > 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\kernel32.dll	SUCC=
ESS	Image Base: 0x77130000, Image Size: 0x11f000
> > 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\KernelBase.dll	SU=
CCESS	Image Base: 0x7fefcde0000, Image Size: 0x6a000
> > 9:55:51.2	git.exe	5604	Load Image	C:\Program Files\Git\mingw64\bin\libi=
conv-2.dll	SUCCESS	Image Base: 0x66000000, Image Size: 0x10b000
> > 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\msvcrt.dll	SUCCES=
S	Image Base: 0x7fefd950000, Image Size: 0x9f000
> > 9:55:51.2	git.exe	5604	Load Image	C:\Program Files\Git\mingw64\bin\libi=
ntl-8.dll	SUCCESS	Image Base: 0x61cc0000, Image Size: 0x28000
> > 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\advapi32.dll	SUCC=
ESS	Image Base: 0x7fefd7d0000, Image Size: 0xdb000
> > 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\sechost.dll	SUCCE=
SS	Image Base: 0x7feff520000, Image Size: 0x1f000
> > 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\rpcrt4.dll	SUCCES=
S	Image Base: 0x7fefebf0000, Image Size: 0x12d000
> > 9:55:51.2	git.exe	5604	Load Image	C:\Program Files\Git\mingw64\bin\libp=
cre2-8-0.dll	SUCCESS	Image Base: 0x64380000, Image Size: 0x54000
> > 9:55:51.2	git.exe	5604	Load Image	C:\Program Files\Git\mingw64\bin\zlib=
1.dll	SUCCESS	Image Base: 0x62e80000, Image Size: 0x1f000
> > 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\user32.dll	SUCCES=
S	Image Base: 0x77030000, Image Size: 0xfa000
> > 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\gdi32.dll	SUCCESS=
	Image Base: 0x7fefd6c0000, Image Size: 0x67000
> > 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\lpk.dll	SUCCESS	I=
mage Base: 0x7fefd290000, Image Size: 0xe000
> > 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\usp10.dll	SUCCESS=
	Image Base: 0x7fefd5f0000, Image Size: 0xcb000
> > 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\ws2_32.dll	SUCCES=
S	Image Base: 0x7fefd240000, Image Size: 0x4d000
> > 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\nsi.dll	SUCCESS	I=
mage Base: 0x7fefed50000, Image Size: 0x8000
> > 9:55:51.2	git.exe	5604	Load Image	C:\Program Files\Git\mingw64\bin\libs=
sp-0.dll	SUCCESS	Image Base: 0x68ac0000, Image Size: 0xe000
> > 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\imm32.dll	SUCCESS=
	Image Base: 0x7fefed20000, Image Size: 0x2e000
> > 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\msctf.dll	SUCCESS=
	Image Base: 0x7feff410000, Image Size: 0x109000
> > 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\nvinitx.dll	SUCCE=
SS	Image Base: 0x7fefccd0000, Image Size: 0x31000
> > 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\version.dll	SUCCE=
SS	Image Base: 0x7fefccc0000, Image Size: 0xc000
> > 9:55:51.3	git.exe	5604	Load Image	C:\Windows\System32\cryptsp.dll	SUCCE=
SS	Image Base: 0x7fefc530000, Image Size: 0x18000
> > 9:55:51.3	git.exe	5604	Load Image	C:\Windows\System32\rsaenh.dll	SUCCES=
S	Image Base: 0x7fefc230000, Image Size: 0x47000
> > 9:55:51.3	git.exe	5604	Load Image	C:\Windows\System32\cryptbase.dll	SUC=
CESS	Image Base: 0x7fefcbf0000, Image Size: 0xf000
> > 9:55:51.3	git.exe	5604	Thread Exit		SUCCESS	Thread ID: 8844, User Time:=
 0.0000000, Kernel Time: 0.0468003
> > 9:55:51.3	git.exe	5604	Process Exit		SUCCESS	Exit Status: 0, User Time:=
 0.0000000 seconds, Kernel Time: 0.0468003 seconds, Private Bytes: 2,940,92=
8, Peak Private Bytes: 2,981,888, Working Set: 4,980,736, Peak Working Set:=
 4,980,736
> > 9:55:51.6	git.exe	5560	Process Start		SUCCESS	"Parent PID: 9080, Comman=
d line: ""C:\Program Files\Git\mingw64\bin\git.exe"" rev-parse --git-dir --=
is-inside-git-dir --is-bare-repository --is-inside-work-tree --short HEAD, =
Current directory: C:\Users\gpierre\, Environment:=20
> > 9:55:51.6	git.exe	5560	Thread Create		SUCCESS	Thread ID: 5248
> > 9:55:51.6	git.exe	5560	Load Image	C:\Program Files\Git\mingw64\bin\git.=
exe	SUCCESS	Image Base: 0x190000, Image Size: 0x2f0000
> > 9:55:51.6	git.exe	5560	Load Image	C:\Windows\System32\ntdll.dll	SUCCESS=
	Image Base: 0x77250000, Image Size: 0x19f000
> > 9:55:51.6	git.exe	5560	Load Image	C:\Windows\System32\kernel32.dll	SUCC=
ESS	Image Base: 0x77130000, Image Size: 0x11f000
> > 9:55:51.6	git.exe	5560	Load Image	C:\Windows\System32\KernelBase.dll	SU=
CCESS	Image Base: 0x7fefcde0000, Image Size: 0x6a000
> > 9:55:51.6	git.exe	5560	Load Image	C:\Program Files\Git\mingw64\bin\libi=
conv-2.dll	SUCCESS	Image Base: 0x66000000, Image Size: 0x10b000
> > 9:55:51.6	git.exe	5560	Load Image	C:\Windows\System32\msvcrt.dll	SUCCES=
S	Image Base: 0x7fefd950000, Image Size: 0x9f000
> > 9:55:51.6	git.exe	5560	Load Image	C:\Program Files\Git\mingw64\bin\libi=
ntl-8.dll	SUCCESS	Image Base: 0x61cc0000, Image Size: 0x28000
> > 9:55:51.6	git.exe	5560	Load Image	C:\Windows\System32\advapi32.dll	SUCC=
ESS	Image Base: 0x7fefd7d0000, Image Size: 0xdb000
> > 9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\sechost.dll	SUCCE=
SS	Image Base: 0x7feff520000, Image Size: 0x1f000
> > 9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\rpcrt4.dll	SUCCES=
S	Image Base: 0x7fefebf0000, Image Size: 0x12d000
> > 9:55:51.7	git.exe	5560	Load Image	C:\Program Files\Git\mingw64\bin\libp=
cre2-8-0.dll	SUCCESS	Image Base: 0x64380000, Image Size: 0x54000
> > 9:55:51.7	git.exe	5560	Load Image	C:\Program Files\Git\mingw64\bin\zlib=
1.dll	SUCCESS	Image Base: 0x62e80000, Image Size: 0x1f000
> > 9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\user32.dll	SUCCES=
S	Image Base: 0x77030000, Image Size: 0xfa000
> > 9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\gdi32.dll	SUCCESS=
	Image Base: 0x7fefd6c0000, Image Size: 0x67000
> > 9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\lpk.dll	SUCCESS	I=
mage Base: 0x7fefd290000, Image Size: 0xe000
> > 9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\usp10.dll	SUCCESS=
	Image Base: 0x7fefd5f0000, Image Size: 0xcb000
> > 9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\ws2_32.dll	SUCCES=
S	Image Base: 0x7fefd240000, Image Size: 0x4d000
> > 9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\nsi.dll	SUCCESS	I=
mage Base: 0x7fefed50000, Image Size: 0x8000
> > 9:55:51.7	git.exe	5560	Load Image	C:\Program Files\Git\mingw64\bin\libs=
sp-0.dll	SUCCESS	Image Base: 0x68ac0000, Image Size: 0xe000
> > 9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\imm32.dll	SUCCESS=
	Image Base: 0x7fefed20000, Image Size: 0x2e000
> > 9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\msctf.dll	SUCCESS=
	Image Base: 0x7feff410000, Image Size: 0x109000
> > 9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\nvinitx.dll	SUCCE=
SS	Image Base: 0x7fefccd0000, Image Size: 0x31000
> > 9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\version.dll	SUCCE=
SS	Image Base: 0x7fefccc0000, Image Size: 0xc000
> > 9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\cryptsp.dll	SUCCE=
SS	Image Base: 0x7fefc530000, Image Size: 0x18000
> > 9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\rsaenh.dll	SUCCES=
S	Image Base: 0x7fefc230000, Image Size: 0x47000
> > 9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\cryptbase.dll	SUC=
CESS	Image Base: 0x7fefcbf0000, Image Size: 0xf000
> > 9:55:51.7	git.exe	5560	Thread Exit		SUCCESS	Thread ID: 5248, User Time:=
 0.0000000, Kernel Time: 0.0780005
> > 9:55:51.7	git.exe	5560	Process Exit		SUCCESS	Exit Status: 128, User Tim=
e: 0.0000000 seconds, Kernel Time: 0.0780005 seconds, Private Bytes: 2,932,=
736, Peak Private Bytes: 2,973,696, Working Set: 5,062,656, Peak Working Se=
t: 5,062,656
> >=20
> >=20
> > Thanks a lot! Cheers,
> > Pierre G.
> >=20
> >=20
>=20
